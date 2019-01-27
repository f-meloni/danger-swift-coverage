import XCTest
@testable import DangerSwiftCoverage
import DangerFixtures
@testable import Danger

final class CoverageTests: XCTestCase {
    var dsl: DangerDSL!
    
    override func setUp() {
        super.setUp()
        MockXcodeBuildCoverageParser.receivedDataFolder = nil
        MockXcodeBuildCoverageParser.receivedFiles = nil
        MockXcodeBuildCoverageParser.shouldSucceed = false
    }
    
    override func tearDown() {
        dsl = nil
        resetDangerResults()
        
        super.tearDown()
    }
    
    func testItSendsAFailMessageIfFailsToParseTheXcodeBuildCoverage() {
        dsl = githubFixtureDSL
        Coverage.xcodeBuildCoverage(derivedDataFolder: "derived", minimumCoverage: 50, fileManager: FakeCurrentPathProvider(), xcodeBuildCoverageParser: MockXcodeBuildCoverageParser.self, danger: dsl)
        
        XCTAssertEqual(dsl.fails.count, 1)
        XCTAssertEqual(dsl.fails[0].message, "Failed to get the coverage - Error: Fake Error")
    }
    
    func testItSendsTheCorrectParametersToTheXcodeBuildCoverageParser() {
        let created = [
            ".travis.yml",
            "Tests/Test.swift"
        ]
        
        let modified = [
            "Sources/Coverage.swift"
        ]
        
        dsl = githubWithFilesDSL(created: created, modified: modified)
        
        let currentPathProvider = FakeCurrentPathProvider()
        
        Coverage.xcodeBuildCoverage(derivedDataFolder: "derived", minimumCoverage: 50, fileManager: currentPathProvider, xcodeBuildCoverageParser: MockXcodeBuildCoverageParser.self, danger: dsl)
        
        XCTAssertEqual(MockXcodeBuildCoverageParser.receivedDataFolder, "derived")
        XCTAssertEqual(MockXcodeBuildCoverageParser.receivedFiles, (created + modified).map { currentPathProvider.fakePath + "/" + $0 })
    }
    
    func testItSendsTheCorrectRepoToDanger() {
        dsl = githubWithFilesDSL()
        MockXcodeBuildCoverageParser.shouldSucceed = true
        
        Coverage.xcodeBuildCoverage(derivedDataFolder: "derived", minimumCoverage: 50, fileManager: FakeCurrentPathProvider(), xcodeBuildCoverageParser: MockXcodeBuildCoverageParser.self, danger: dsl)
        
        XCTAssertEqual(dsl.messages.map { $0.message }, ["TestMessage1", "TestMessage2"])
        
        XCTAssertEqual(dsl.markdowns.map { $0.message }, [
            """
            ## Danger.framework: Coverage: 43.44%
            | File | Coverage ||
            | --- | --- | --- |
            BitBucketServerDSL.swift | 100.0% | ✅
            Danger.swift | 0.0% | ❌\n
            """,
            """
            ## RunnerLib.framework: Coverage: 66.67%
            | File | Coverage ||
            | --- | --- | --- |
            ImportsFinder.swift | 100.0% | ✅
            HelpMessagePresenter.swift | 100.0% | ✅\n
            """
        ])
    }
}

fileprivate final class FakeCurrentPathProvider: FileManager {
    let fakePath = "/usr/franco"
    
    override var currentDirectoryPath: String {
        return fakePath
    }
}

fileprivate final class MockXcodeBuildCoverageParser: XcodeBuildCoverageParsing {
    static var receivedFiles: [String]!
    static var receivedDataFolder: String!
    
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
                    ReportFile(fileName: "Danger.swift", coverage: 0)
            ]),
            ReportSection(titleText: "RunnerLib.framework: Coverage: 66.67%", items: [
                ReportFile(fileName: "ImportsFinder.swift", coverage: 100),
                ReportFile(fileName: "HelpMessagePresenter.swift", coverage: 100)
            ]),
        ])
    
    static func coverage(derivedDataFolder: String, files: [String]) throws -> Report {
        receivedFiles = files
        receivedDataFolder = derivedDataFolder
        
        if shouldSucceed {
            return fakeReport
        } else {
            throw FakeError.fakeError
        }
    }
}
