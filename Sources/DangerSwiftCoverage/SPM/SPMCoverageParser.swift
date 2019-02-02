import Foundation

enum SPMCoverageParser {
    enum Errors: Error {
        case buildFolderNotFound
    }
    
    static func coverage(spmCoverageFilePath: String, files: [String],  fileManager: FileManager = .default) throws -> Report {
        let url = URL(fileURLWithPath: fileManager.currentDirectoryPath + "/" + spmCoverageFilePath)
        let data = try Data(contentsOf: url)
        let coverage = try JSONDecoder().decode(SPMCoverage.self, from: data)
        let filteredCoverage = coverage.filteringFiles(withFiles: files)
        
        return Report(messages: [], sections: [ReportSection(fromSPM: filteredCoverage, fileManager: fileManager)])
    }
}
