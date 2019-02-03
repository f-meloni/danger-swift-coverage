@testable import DangerSwiftCoverage
import XCTest

final class XcCovJSONTests: XCTestCase {
    func testItExectuesTheCorrectCommand() {
        let executor = SpyShellOutExecutor()
        let testPath = "test/test.xcodecov"
        let data = try! XcCovJSONParser.json(fromXCoverageFile: testPath, shellOutExecutor: executor)

        XCTAssertEqual(executor.receivedCommand, "xcrun xccov view \(testPath) --json")
        XCTAssertEqual(data, executor.testResult.data(using: .utf8))
    }
}

private final class SpyShellOutExecutor: ShellOutExecuting {
    var receivedCommand: String?
    let testResult = "test"

    func execute(command: String) throws -> String {
        receivedCommand = command
        return testResult
    }
}
