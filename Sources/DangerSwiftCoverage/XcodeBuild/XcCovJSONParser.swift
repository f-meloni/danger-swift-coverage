import Foundation

protocol XcCovJSONParsing {
    static func json(fromXCoverageFile file: String) throws -> Data
}

enum XcCovJSONParser: XcCovJSONParsing {
    static func json(fromXCoverageFile file: String) throws -> Data {
        return try json(fromXCoverageFile: file, shellOutExecutor: ShellOutExecutor())
    }

    static func json(fromXCoverageFile file: String, shellOutExecutor: ShellOutExecuting) throws -> Data {
        let json = try shellOutExecutor.execute(command: "xcrun xccov view \(file) --json")
        return json.data(using: .utf8) ?? Data()
    }
}
