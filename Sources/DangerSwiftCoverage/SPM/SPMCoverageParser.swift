import Foundation

protocol SPMCoverageParsing {
    static func coverage(spmCoverageFilePath: String, files: [String]) throws -> Report
}

enum SPMCoverageParser: SPMCoverageParsing {
    enum Errors: Error {
        case buildFolderNotFound
    }

    static func coverage(spmCoverageFilePath: String, files: [String]) throws -> Report {
        return try coverage(spmCoverageFilePath: spmCoverageFilePath, files: files, fileManager: .default)
    }

    static func coverage(spmCoverageFilePath: String, files: [String], fileManager: FileManager) throws -> Report {
        let url = URL(fileURLWithPath: fileManager.currentDirectoryPath + "/" + spmCoverageFilePath)
        let data = try Data(contentsOf: url)
        let coverage = try JSONDecoder().decode(SPMCoverage.self, from: data)
        let filteredCoverage = coverage.filteringFiles(notOn: files)

        return Report(messages: [], sections: [ReportSection(fromSPM: filteredCoverage, fileManager: fileManager)])
    }
}
