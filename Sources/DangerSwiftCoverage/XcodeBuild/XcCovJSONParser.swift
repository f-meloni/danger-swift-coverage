import Foundation

enum XcCovJSONParserError: LocalizedError {
    case invalidData

    var errorDescription: String? {
        switch self {
        case .invalidData:
            return "Invalid coverage report"
        }
    }
}

protocol XcCovJSONParsing {
    static func json(fromXcresultFile file: String) throws -> Data
}

enum XcCovJSONParser: XcCovJSONParsing {
    static func json(fromXcresultFile file: String) throws -> Data {
        try json(fromXcresultFile: file, shellOutExecutor: ShellOutExecutor())
    }

    static func json(fromXcresultFile file: String, shellOutExecutor: ShellOutExecuting) throws -> Data {
        try jsonData(fromCommand: "xcrun xccov view --report --json \(file)", shellOutExecutor: shellOutExecutor)
    }

    private static func jsonData(fromCommand command: String, shellOutExecutor: ShellOutExecuting) throws -> Data {
        if let json = try? shellOutExecutor.execute(command: command) {
            return json
        } else {
            throw XcCovJSONParserError.invalidData
        }
    }
}
