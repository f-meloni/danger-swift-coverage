import DangerShellExecutor
import Foundation

protocol ShellOutExecuting {
    func execute(command: String) throws -> Data
}

struct ShellOutExecutor: ShellOutExecuting {
    func execute(command: String) throws -> Data {
        let tmpDir: String
        if #available(OSX 10.12, *) {
            tmpDir = FileManager.default.temporaryDirectory.path
        } else {
            tmpDir = NSTemporaryDirectory()
        }

        let file = tmpDir + "/file"
        defer {
            try? FileManager.default.removeItem(atPath: file)
        }

        ShellExecutor().execute(command + " > \(file)", arguments: [])

        print(command + " > \(file)")

        return try NSData(contentsOfFile: file) as Data
    }
}
