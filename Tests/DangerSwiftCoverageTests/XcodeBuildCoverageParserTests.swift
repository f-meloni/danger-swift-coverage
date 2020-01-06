@testable import DangerSwiftCoverage
import XCTest

final class XcodeBuildCoverageParserTests: XCTestCase {
    override func setUp() {
        super.setUp()
        MockedXcCovJSONParser.receivedXCoverageFile = nil
        MockedXcCovJSONParser.xcoverageResult = XcCovJSONResponse.data(using: .utf8)
        FakeXcodeCoverageFileFinder.receivedXcresultBundlePath = nil
    }

    override func tearDown() {
        super.tearDown()
        MockedXcCovJSONParser.receivedXCoverageFile = nil
        MockedXcCovJSONParser.xcoverageResult = nil
        MockedXcCovJSONParser.receivedXcresultFile = nil
        MockedXcCovJSONParser.xcresultResult = nil
    }

    func testItParsesTheJSONCorrectly() throws {
        let files = ["/Users/franco/Projects/swift/Sources/Danger/BitBucketServerDSL.swift",
                     "/Users/franco/Projects/swift/Sources/Danger/Danger.swift",
                     "/Users/franco/Projects/swift/Sources/RunnerLib/Files Import/ImportsFinder.swift",
                     "/Users/franco/Projects/swift/Sources/RunnerLib/HelpMessagePresenter.swift"]

        let result = try XcodeBuildCoverageParser.coverage(xcresultBundlePath: "derived", files: files, excludedTargets: [], coverageFileFinder: FakeXcodeCoverageFileFinder.self, xcCovParser: MockedXcCovJSONParser.self)

        XCTAssertEqual("derived", FakeXcodeCoverageFileFinder.receivedXcresultBundlePath)
        XCTAssertEqual(FakeXcodeCoverageFileFinder.result, MockedXcCovJSONParser.receivedXCoverageFile)

        XCTAssertEqual(result.messages, ["Project coverage: 50.09%"])

        let firstSection = result.sections[0]
        XCTAssertEqual(firstSection.titleText, "Danger.framework: Coverage: 43.44")
        XCTAssertEqual(firstSection.items, [
            ReportFile(fileName: "BitBucketServerDSL.swift", coverage: 100),
            ReportFile(fileName: "Danger.swift", coverage: 0),
        ])

        let secondSection = result.sections[1]
        XCTAssertEqual(secondSection.titleText, "RunnerLib.framework: Coverage: 66.67")
        XCTAssertEqual(secondSection.items, [
            ReportFile(fileName: "ImportsFinder.swift", coverage: 100),
            ReportFile(fileName: "HelpMessagePresenter.swift", coverage: 100),
        ])
    }

    func testItFiltersTheExcludedTarget() throws {
        MockedXcCovJSONParser.xcoverageResult = XcCovXcTestJSONResponse.data(using: .utf8)

        let files = ["/Users/franco/Projects/swift/Sources/Danger/BitBucketServerDSL.swift",
                     "/Users/franco/Projects/swift/Sources/Danger/Danger.swift",
                     "/Users/franco/Projects/swift/Sources/RunnerLib/Files Import/ImportsFinder.swift",
                     "/Users/franco/Projects/swift/Sources/RunnerLib/HelpMessagePresenter.swift"]

        let result = try XcodeBuildCoverageParser.coverage(xcresultBundlePath: "derived", files: files, excludedTargets: ["RunnerLib.xctest"], coverageFileFinder: FakeXcodeCoverageFileFinder.self, xcCovParser: MockedXcCovJSONParser.self)

        XCTAssertEqual("derived", FakeXcodeCoverageFileFinder.receivedXcresultBundlePath)
        XCTAssertEqual(FakeXcodeCoverageFileFinder.result, MockedXcCovJSONParser.receivedXCoverageFile)

        XCTAssertEqual(result.messages, ["Project coverage: 50.09%"])

        let firstSection = result.sections[0]
        XCTAssertEqual(firstSection.titleText, "Danger.framework: Coverage: 43.44")
        XCTAssertEqual(firstSection.items, [
            ReportFile(fileName: "BitBucketServerDSL.swift", coverage: 100),
            ReportFile(fileName: "Danger.swift", coverage: 0),
        ])

        XCTAssertEqual(result.sections.count, 1)
    }

    func testItFiltersTheEmptyTargets() throws {
        let files = ["/Users/franco/Projects/swift/Sources/Danger/BitBucketServerDSL.swift",
                     "/Users/franco/Projects/swift/Sources/Danger/Danger.swift"]

        let result = try XcodeBuildCoverageParser.coverage(xcresultBundlePath: "derived", files: files, excludedTargets: [], coverageFileFinder: FakeXcodeCoverageFileFinder.self, xcCovParser: MockedXcCovJSONParser.self)

        let firstSection = result.sections[0]
        XCTAssertEqual(firstSection.titleText, "Danger.framework: Coverage: 43.44")
        XCTAssertEqual(firstSection.items, [
            ReportFile(fileName: "BitBucketServerDSL.swift", coverage: 100),
            ReportFile(fileName: "Danger.swift", coverage: 0),
        ])

        XCTAssertEqual(result.sections.count, 1)
    }

    func testItReturnsTheCoverageWhenThereAreNoTargets() throws {
        let files: [String] = []

        let result = try XcodeBuildCoverageParser.coverage(xcresultBundlePath: "derived", files: files, excludedTargets: [], coverageFileFinder: FakeXcodeCoverageFileFinder.self, xcCovParser: MockedXcCovJSONParser.self)

        XCTAssertEqual(result.messages, [])
        XCTAssertEqual(result.sections.count, 0)
    }

    func testWhenThereIsNoXcoverageFileUsesXcresult() throws {
        let files = ["/Users/franco/Projects/swift/Sources/Danger/BitBucketServerDSL.swift",
                     "/Users/franco/Projects/swift/Sources/Danger/Danger.swift",
                     "/Users/franco/Projects/swift/Sources/RunnerLib/Files Import/ImportsFinder.swift",
                     "/Users/franco/Projects/swift/Sources/RunnerLib/HelpMessagePresenter.swift"]
        FakeXcodeCoverageFileFinder.result = nil
        MockedXcCovJSONParser.xcresultResult = XcCovJSONResponse.data(using: .utf8)

        let result = try XcodeBuildCoverageParser.coverage(xcresultBundlePath: "derived", files: files, excludedTargets: [], coverageFileFinder: FakeXcodeCoverageFileFinder.self, xcCovParser: MockedXcCovJSONParser.self)

        XCTAssertEqual(MockedXcCovJSONParser.receivedXcresultFile, "derived")
        XCTAssertEqual(result.messages, ["Project coverage: 50.09%"])
        let firstSection = result.sections[0]
        XCTAssertEqual(firstSection.titleText, "Danger.framework: Coverage: 43.44")
        XCTAssertEqual(firstSection.items, [
            ReportFile(fileName: "BitBucketServerDSL.swift", coverage: 100),
            ReportFile(fileName: "Danger.swift", coverage: 0),
        ])

        XCTAssertEqual(result.sections.count, 2)
    }

    func testWhenXcoverageFileIsInvalidThrowsAnError() throws {
        MockedXcCovJSONParser.xcoverageResult = nil

        XCTAssertThrowsError(try XcodeBuildCoverageParser.coverage(xcresultBundlePath: "derived", files: [], excludedTargets: [], coverageFileFinder: FakeXcodeCoverageFileFinder.self, xcCovParser: MockedXcCovJSONParser.self)) { error in
            XCTAssertEqual(error.localizedDescription, "Invalid coverage report")
        }
    }

    func testWhenXcresultFileIsInvalidThrowsAnError() throws {
        FakeXcodeCoverageFileFinder.result = nil
        MockedXcCovJSONParser.xcresultResult = nil

        XCTAssertThrowsError(try XcodeBuildCoverageParser.coverage(xcresultBundlePath: "derived", files: [], excludedTargets: [], coverageFileFinder: FakeXcodeCoverageFileFinder.self, xcCovParser: MockedXcCovJSONParser.self)) { error in
            XCTAssertEqual(error.localizedDescription, "Invalid coverage report")
        }
    }
}

private struct FakeXcodeCoverageFileFinder: XcodeCoverageFileFinding {
    static var result: String? = "result.xccoverage"
    static var receivedXcresultBundlePath: String?

    static func coverageFile(xcresultBundlePath: String) -> String? {
        receivedXcresultBundlePath = xcresultBundlePath
        return result
    }
}

private struct MockedXcCovJSONParser: XcCovJSONParsing {
    static var xcoverageResult: Data?
    static var xcresultResult: Data?
    static var receivedXCoverageFile: String?
    static var receivedXcresultFile: String?

    static func json(fromXCoverageFile file: String) throws -> Data {
        receivedXCoverageFile = file
        if let result = xcoverageResult {
            return result
        } else {
            throw XcCovJSONParserError.invalidData
        }
    }

    static func json(fromXcresultFile file: String) throws -> Data {
        receivedXcresultFile = file
        if let result = xcresultResult {
            return result
        } else {
            throw XcCovJSONParserError.invalidData
        }
    }
}

extension ReportFile: Equatable {
    public static func == (lhs: ReportFile, rhs: ReportFile) -> Bool {
        lhs.fileName == rhs.fileName &&
            lhs.coverage == rhs.coverage
    }
}
