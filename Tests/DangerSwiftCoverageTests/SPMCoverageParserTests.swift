@testable import DangerSwiftCoverage
import XCTest

final class SPMCoverageParserTests: XCTestCase {
    func testItDecodesTheJSONCorrectly() throws {
        let testPath = "test.json"

        try spmCoverageJSON.write(toFile: testPath, atomically: false, encoding: .utf8)

        let fileManager = StubbedFileManager()

        var calls = 0
        fileManager.currentPathBlock = {
            let result: String

            if calls == 0 {
                // Workaround to allow the test to actually read the test.json file
                result = FileManager.default.currentDirectoryPath
            } else {
                result = "/Users/franco/Projects/Logger"
            }

            calls += 1
            return result
        }

        fileManager.stubbedContentOfDirectoryBlock = { _ in
            [testPath]
        }

        let report = try! SPMCoverageParser.coverage(spmCoverageFolder: ".", files: ["/Users/franco/Projects/Logger/Sources/Logger/Logger.swift"], fileManager: fileManager)

        XCTAssertEqual(report.sections[0].items.count, 1)
        XCTAssertEqual(report.sections[0].items[0].fileName, "Sources/Logger/Logger.swift")
        XCTAssertEqual(report.sections[0].items[0].coverage, 85)
    }
}
