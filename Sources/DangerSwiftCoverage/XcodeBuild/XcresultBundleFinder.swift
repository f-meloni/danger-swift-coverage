import Foundation

protocol XcresultBundleFinding {
    static func findXcresultFile(derivedDataFolder: String, fileManager: FileManager) throws -> String
}

enum XcresultBundleFinder: XcresultBundleFinding {
    enum Errors: LocalizedError {
        case xcresultNotFound

        var errorDescription: String? {
            "Could not find the xcresult file"
        }
    }

    static func findXcresultFile(derivedDataFolder: String, fileManager: FileManager) throws -> String {
        let testFolder = derivedDataFolder + "/Logs/Test/"

        guard let xcresults = try? fileManager.contentsOfDirectory(atPath: testFolder).filter({ $0.split(separator: ".").last == "xcresult" }),
            !xcresults.isEmpty else {
            throw Errors.xcresultNotFound
        }

        let xcresult = testFolder + xcresults.sorted(by: { (left, right) -> Bool in
            let leftModificationDate = fileManager.modificationDate(forFileAtPath: testFolder + left)?.timeIntervalSince1970 ?? 0
            let rightModificationDate = fileManager.modificationDate(forFileAtPath: testFolder + right)?.timeIntervalSince1970 ?? 0

            return leftModificationDate > rightModificationDate
        }).first!

        return xcresult
    }
}

extension FileManager {
    func modificationDate(forFileAtPath path: String) -> Date? {
        guard let attributes = try? attributesOfItem(atPath: path) else {
            return nil
        }

        return attributes[.modificationDate] as? Date
    }
}
