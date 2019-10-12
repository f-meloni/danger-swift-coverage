@testable import DangerSwiftCoverage
import XCTest

final class XcCovJSONTests: XCTestCase {
    func testWhenJSONIsFromXcoverageItExectuesTheCorrectCommand() {
        let executor = SpyShellOutExecutor()
        let testPath = "test/test.xcodecov"
        let data = try! XcCovJSONParser.json(fromXCoverageFile: testPath, shellOutExecutor: executor)

        XCTAssertEqual(executor.receivedCommand, "xcrun xccov view \(testPath) --json")
        XCTAssertEqual(data, executor.testResult.data(using: .utf8))
    }
    
    func testWhenJSONIsFromXcresultItExectuesTheCorrectCommand() {
        let executor = SpyShellOutExecutor()
        let testPath = "test/test.xcodecov"
        let data = try! XcCovJSONParser.json(fromXcresultFile: testPath, shellOutExecutor: executor)

        XCTAssertEqual(executor.receivedCommand, "xcrun xccov view --report --json \(testPath)")
        XCTAssertEqual(data, executor.testResult.data(using: .utf8))
    }
}

private final class SpyShellOutExecutor: ShellOutExecuting {
    var receivedCommand: String?
    let testResult = "test"

    func execute(command: String) throws -> Data {
        receivedCommand = command
        return testResult.data(using: .utf8)!
    }
}
