import Foundation

protocol XcodeCoverageFileFinding {
    static func coverageFile(derivedDataFolder: String) throws -> String
}

enum XcodeCoverageFileFinder: XcodeCoverageFileFinding {
    enum Errors: LocalizedError {
        case xcresultNotFound
        case xcodeCovReportNotFound

        var errorDescription: String? {
            switch self {
            case .xcresultNotFound:
                return "Could not find the xcresult file"
            case .xcodeCovReportNotFound:
                return "Could not find the xccovreport file"
            }
        }
    }

    static func coverageFile(derivedDataFolder: String) throws -> String {
        return try coverageFile(derivedDataFolder: derivedDataFolder, fileManager: .default)
    }

    static func coverageFile(derivedDataFolder: String, fileManager: FileManager) throws -> String {
        let testFolder = derivedDataFolder + "/Logs/Test/"

        guard let xcresults = try? fileManager.contentsOfDirectory(atPath: testFolder).filter({ $0.split(separator: ".").last == "xcresult" }),
            xcresults.count > 0 else {
            throw Errors.xcresultNotFound
        }

        let xcresult = testFolder + xcresults.sorted(by: { (left, right) -> Bool in
            let leftModificationDate = fileManager.modificationDate(forFileAtPath: left)?.timeIntervalSince1970 ?? 0
            let rightModificationDate = fileManager.modificationDate(forFileAtPath: right)?.timeIntervalSince1970 ?? 0

            return leftModificationDate > rightModificationDate
        }).first!

        let xcresultContent = try? fileManager.contentsOfDirectory(atPath: xcresult).map { xcresult + "/" + $0 }

        guard let coverageFile = firstCoverageFile(fromXcresultContent: xcresultContent, fileManager: fileManager) else {
            throw Errors.xcodeCovReportNotFound
        }

        return coverageFile
    }

    private static func firstCoverageFile(fromXcresultContent xcresultContent: [String]?, fileManager: FileManager) -> String? {
        return xcresultContent?.lazy.compactMap { directory -> String? in
            (try? fileManager.contentsOfDirectory(atPath: directory).compactMap { file -> String? in
                file == "action.xccovreport" ? directory + "/" + file : nil
            })?.first
        }.first
    }
}

extension FileManager {
    func modificationDate(forFileAtPath path: String) -> Date? {
        guard let attributes = try? FileManager.default.attributesOfItem(atPath: path) else {
            return nil
        }

        return attributes[.modificationDate] as? Date
    }
}
