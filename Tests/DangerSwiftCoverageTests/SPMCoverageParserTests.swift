import XCTest
@testable import DangerSwiftCoverage

final class SPMCoverageParserTests: XCTestCase {
    func testItDecodesTheJSONCorrectly() throws {
        let testPath = "test.json"
        
        try spmCoverageJSON.write(toFile: testPath, atomically: false, encoding: .utf8)
        
        let coverage = try! SPMCoverageParser.coverage(spmCoverageFilePath: testPath)
        
        XCTAssertEqual(coverage.data[0].files.count, 61)
        XCTAssertEqual(coverage.data[0].files[53].filename, "/Users/franco/Projects/Logger/Sources/Logger/Logger.swift")
        XCTAssertEqual(coverage.data[0].files[53].summary.count, 34)
        XCTAssertEqual(coverage.data[0].files[53].summary.covered, 29)
        XCTAssertEqual(coverage.data[0].files[53].summary.percent, 85)
    }
}
