import Foundation

enum SPMCoverageParser {
    enum Errors: Error {
        case buildFolderNotFound
    }
    
    static func coverage(spmCoverageFilePath: String, fileManager: FileManager = .default) throws -> SPMCoverage {
        let url = URL(fileURLWithPath: fileManager.currentDirectoryPath + "/" + spmCoverageFilePath)
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(SPMCoverage.self, from: data)
    }
}
