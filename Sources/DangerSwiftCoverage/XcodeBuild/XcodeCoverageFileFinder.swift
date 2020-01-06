import Foundation

protocol XcodeCoverageFileFinding {
    static func coverageFile(xcresultBundlePath: String) -> String?
}

enum XcodeCoverageFileFinder: XcodeCoverageFileFinding {
    static func coverageFile(xcresultBundlePath: String) -> String? {
        coverageFile(xcresultBundlePath: xcresultBundlePath, fileManager: .default)
    }

    static func coverageFile(xcresultBundlePath: String, fileManager: FileManager) -> String? {
        let xcresultContent = try? fileManager.contentsOfDirectory(atPath: xcresultBundlePath).map { xcresultBundlePath + "/" + $0 }

        if let coverageFile = firstCoverageFile(fromXcresultContent: xcresultContent, fileManager: fileManager) {
            return coverageFile
        } else {
            return nil
        }
    }

    private static func firstCoverageFile(fromXcresultContent xcresultContent: [String]?, fileManager: FileManager) -> String? {
        xcresultContent?.lazy.compactMap { directory -> String? in
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
