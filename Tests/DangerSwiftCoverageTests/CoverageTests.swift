@testable import Danger
import DangerFixtures
@testable import DangerSwiftCoverage
import XCTest

final class CoverageTests: XCTestCase {
    var dsl: DangerDSL!

    var created: [String] {
        return [
            ".travis.yml",
            "Tests/Test.swift",
        ]
    }

    var modified: [String] {
        return [
            "Sources/Coverage.swift",
        ]
    }

    override func tearDown() {
        dsl = nil
        resetDangerResults()
        MockXcodeBuildCoverageParser.resetValues()
        MockSPMCoverageParser.resetValues()
        FakeXcodeResultBundleFinder.resetValues()
        super.tearDown()
    }

    func testItSendsAFailMessageIfFailsToParseTheXcodeBuildCoverage() {
        dsl = githubFixtureDSL
        Coverage.xcodeBuildCoverage(.derivedDataFolder("derived"), minimumCoverage: 50, excludedTargets: [], fileManager: StubbedFileManager(), xcodeBuildCoverageParser: MockXcodeBuildCoverageParser.self, xcresultFinder: FakeXcodeResultBundleFinder.self, danger: dsl)

        XCTAssertEqual(dsl.fails.count, 1)
        XCTAssertEqual(dsl.fails[0].message, "Failed to get the coverage - Error: Fake Error")
    }

    func testItSendsTheCorrectParametersToTheXcodeBuildCoverageParser() {
        dsl = githubWithFilesDSL(created: created, modified: modified)

        let currentPathProvider = StubbedFileManager()
        let excluedTargets = ["TargetA.framework", "TargetB.framework"]

        Coverage.xcodeBuildCoverage(.derivedDataFolder("derived"), minimumCoverage: 50, excludedTargets: excluedTargets, fileManager: currentPathProvider, xcodeBuildCoverageParser: MockXcodeBuildCoverageParser.self, xcresultFinder: FakeXcodeResultBundleFinder.self, danger: dsl)

        XCTAssertEqual(MockXcodeBuildCoverageParser.receivedXcresultBundlePath, FakeXcodeResultBundleFinder.result)
        XCTAssertEqual(MockXcodeBuildCoverageParser.receivedExcludedTargets, excluedTargets)
        XCTAssertEqual(MockXcodeBuildCoverageParser.receivedFiles, (created + modified).map { currentPathProvider.fakePath + "/" + $0 })
    }

    func testItSendsTheCorrectParametersToTheXcodeBuildCoverageParserWhenTheXcresultBundlePathIsCustom() {
        dsl = githubWithFilesDSL(created: created, modified: modified)

        let currentPathProvider = StubbedFileManager()
        let excluedTargets = ["TargetA.framework", "TargetB.framework"]

        Coverage.xcodeBuildCoverage(.xcresultBundle("custom"), minimumCoverage: 50, excludedTargets: excluedTargets, fileManager: currentPathProvider, xcodeBuildCoverageParser: MockXcodeBuildCoverageParser.self, xcresultFinder: FakeXcodeResultBundleFinder.self, danger: dsl)

        XCTAssertEqual(MockXcodeBuildCoverageParser.receivedXcresultBundlePath, "custom")
        XCTAssertEqual(MockXcodeBuildCoverageParser.receivedExcludedTargets, excluedTargets)
        XCTAssertEqual(MockXcodeBuildCoverageParser.receivedFiles, (created + modified).map { currentPathProvider.fakePath + "/" + $0 })
    }

    func testItSendsTheCorrectReportToDangerForXCodebuild() {
        dsl = githubWithFilesDSL()
        MockXcodeBuildCoverageParser.shouldSucceed = true

        Coverage.xcodeBuildCoverage(.derivedDataFolder("derived"), minimumCoverage: 50, excludedTargets: [], fileManager: StubbedFileManager(), xcodeBuildCoverageParser: MockXcodeBuildCoverageParser.self, xcresultFinder: FakeXcodeResultBundleFinder.self, danger: dsl)

        XCTAssertEqual(dsl.messages.map { $0.message }, ["TestMessage1", "TestMessage2"])

        XCTAssertEqual(dsl.markdowns.map { $0.message }, [
            """
            ## Danger.framework: Coverage: 43.44%
            | File | Coverage ||
            | --- | --- | --- |
            BitBucketServerDSL.swift | 100.0% | ✅
            Danger.swift | 0.0% | ⚠️\n
            """,
            """
            ## RunnerLib.framework: Coverage: 66.67%
            | File | Coverage ||
            | --- | --- | --- |
            ImportsFinder.swift | 100.0% | ✅
            HelpMessagePresenter.swift | 100.0% | ✅\n
            """,
        ])
    }

    func testItSendsTheCorrectParametersToTheSPMCoverageParser() {
        dsl = githubWithFilesDSL(created: created, modified: modified)

        let currentPathProvider = StubbedFileManager()

        Coverage.spmCoverage(spmCoverageFolder: ".build/debug", minimumCoverage: 50, spmCoverageParser: MockSPMCoverageParser.self, fileManager: currentPathProvider, danger: dsl)

        XCTAssertEqual(MockSPMCoverageParser.receivedSPMCoverageFilePath, ".build/debug")
        XCTAssertEqual(MockSPMCoverageParser.receivedFiles, (created + modified).map { currentPathProvider.fakePath + "/" + $0 })
    }

    func testItSendsTheCorrectReportToDangerForSPM() {
        dsl = githubWithFilesDSL()
        MockSPMCoverageParser.shouldSucceed = true

        Coverage.spmCoverage(spmCoverageFolder: ".build/debug", minimumCoverage: 50, spmCoverageParser: MockSPMCoverageParser.self, fileManager: StubbedFileManager(), danger: dsl)

        XCTAssertEqual(dsl.messages.map { $0.message }, [])

        XCTAssertEqual(dsl.markdowns.map { $0.message }, [
            """
            | File | Coverage ||
            | --- | --- | --- |
            Sources/Logger/Logger.swift | 85.0% | ✅
            Sources/Logger/NotTested.swift | 0.0% | ⚠️\n
            """,
        ])
    }
}

private final class MockSPMCoverageParser: SPMCoverageParsing {
    static var receivedSPMCoverageFilePath: String!
    static var receivedFiles: [String]!

    static var shouldSucceed = false

    enum FakeError: LocalizedError {
        case fakeError

        var errorDescription: String? {
            return "Fake Error"
        }
    }

    static let fakeReport = Report(messages: [],
                                   sections:
                                   [
                                       ReportSection(titleText: nil, items: [
                                           ReportFile(fileName: "Sources/Logger/Logger.swift", coverage: 85),
                                           ReportFile(fileName: "Sources/Logger/NotTested.swift", coverage: 0),
                                       ]),
    ])

    static func coverage(spmCoverageFolder spmCoverageFilePath: String, files: [String]) throws -> Report {
        receivedSPMCoverageFilePath = spmCoverageFilePath
        receivedFiles = files

        if shouldSucceed {
            return MockSPMCoverageParser.fakeReport
        } else {
            throw FakeError.fakeError
        }
    }

    static func resetValues() {
        receivedFiles = nil
        receivedSPMCoverageFilePath = nil
        shouldSucceed = false
    }
}

private final class FakeXcodeResultBundleFinder: XcresultBundleFinding {
    static var receivedDerivedDataFolder: String!
    static let result = "/test/1.xcoderesult"

    static func findXcresultFile(derivedDataFolder: String, fileManager _: FileManager) throws -> String {
        receivedDerivedDataFolder = derivedDataFolder
        return result
    }

    static func resetValues() {
        receivedDerivedDataFolder = nil
    }
}

private final class MockXcodeBuildCoverageParser: XcodeBuildCoverageParsing {
    static var receivedFiles: [String]!
    static var receivedXcresultBundlePath: String!
    static var receivedExcludedTargets: [String]!

    static var shouldSucceed = false

    enum FakeError: LocalizedError {
        case fakeError

        var errorDescription: String? {
            return "Fake Error"
        }
    }

    static let fakeReport = Report(messages: ["TestMessage1", "TestMessage2"],
                                   sections:
                                   [
                                       ReportSection(titleText: "Danger.framework: Coverage: 43.44%", items: [
                                           ReportFile(fileName: "BitBucketServerDSL.swift", coverage: 100),
                                           ReportFile(fileName: "Danger.swift", coverage: 0),
                                       ]),
                                       ReportSection(titleText: "RunnerLib.framework: Coverage: 66.67%", items: [
                                           ReportFile(fileName: "ImportsFinder.swift", coverage: 100),
                                           ReportFile(fileName: "HelpMessagePresenter.swift", coverage: 100),
                                       ]),
    ])

    static func coverage(xcresultBundlePath: String, files: [String], excludedTargets: [String]) throws -> Report {
        receivedFiles = files
        receivedXcresultBundlePath = xcresultBundlePath
        receivedExcludedTargets = excludedTargets

        if shouldSucceed {
            return MockXcodeBuildCoverageParser.fakeReport
        } else {
            throw FakeError.fakeError
        }
    }

    static func resetValues() {
        receivedXcresultBundlePath = nil
        receivedFiles = nil
        receivedExcludedTargets = nil
        shouldSucceed = false
    }
}
