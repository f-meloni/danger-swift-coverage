import Foundation

protocol SPMCoverageParsing {
    static func coverage(spmCoverageFolder: String, files: [String]) throws -> Report
}

enum SPMCoverageParser: SPMCoverageParsing {
    enum Errors: Error {
        case coverageFileNotFound
    }

    static func coverage(spmCoverageFolder: String, files: [String]) throws -> Report {
        try coverage(spmCoverageFolder: spmCoverageFolder, files: files, fileManager: .default)
    }

    static func coverage(spmCoverageFolder: String, files: [String], fileManager: FileManager) throws -> Report {
        guard let jsonFileName = try fileManager.contentsOfDirectory(atPath: spmCoverageFolder).first(where: { $0.split(separator: ".").last == "json" }) else {
            throw Errors.coverageFileNotFound
        }
        let url = URL(fileURLWithPath: fileManager.currentDirectoryPath + "/" + spmCoverageFolder + "/" + jsonFileName)
        let data = try Data(contentsOf: url)
        let coverage = try JSONDecoder().decode(SPMCoverage.self, from: data)
        let filteredCoverage = coverage.filteringFiles(notOn: files)

        return Report(messages: [], sections: [ReportSection(fromSPM: filteredCoverage, fileManager: fileManager)])
    }
}
