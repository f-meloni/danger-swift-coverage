import XCTest
@testable import DangerSwiftCoverage

final class SPMCoverageParserTests: XCTestCase {
    func testItDecodesTheJSONCorrectly() throws {
        let testPath = "test.json"
        
        try spmCoverageJSON.write(toFile: testPath, atomically: false, encoding: .utf8)
        
        let currentPathProvider = FakeCurrentPathProvider()
        
        
        var calls = 0
        currentPathProvider.currentPathBlock = {
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
        
        let coverage = try! SPMCoverageParser.coverage(spmCoverageFilePath: testPath, files: ["/Users/franco/Projects/Logger/Sources/Logger/Logger.swift"], fileManager: currentPathProvider)
        
        XCTAssertEqual(coverage.sections[0].items.count, 1)
        XCTAssertEqual(coverage.sections[0].items[0].fileName, "Sources/Logger/Logger.swift")
        XCTAssertEqual(coverage.sections[0].items[0].coverage, 85)
    }
}
