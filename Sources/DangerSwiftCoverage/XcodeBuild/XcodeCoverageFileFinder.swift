import Foundation

protocol XcodeCoverageFileFinding {
    static func coverageFile(xcresultBundlePath: String) throws -> String
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

    static func coverageFile(xcresultBundlePath: String) throws -> String {
        return try coverageFile(xcresultBundlePath: xcresultBundlePath, fileManager: .default)
    }

    static func coverageFile(xcresultBundlePath: String, fileManager: FileManager) throws -> String {
        let xcresultContent = try? fileManager.contentsOfDirectory(atPath: xcresultBundlePath).map { xcresultBundlePath + "/" + $0 }

        guard let coverageFile = firstCoverageFile(fromXcresultContent: xcresultContent, fileManager: fileManager) else {
            throw Errors.xcodeCovReportNotFound
        }

        return coverageFile
    }

    private static func firstCoverageFile(fromXcresultContent xcresultContent: [String]?, fileManager: FileManager) -> String? {
        return xcresultContent?.lazy.compactMap { directory -> String? in
            (try? fileManager.contentsOfDirectory(atPath: directory).lazy.compactMap { file -> String? in
                file == "action.xccovreport" ? directory + "/" + file : nil
            })?.first
        }.first
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
