import Foundation

struct SPMCoverage: Decodable {
    let data: [SPMCoverageData]
    
    func filteringFiles(withFiles files: [String], fileManager: FileManager) -> SPMCoverage {
        let data = self.data.map { $0.filteringFiles(withFiles: files, fileManager: fileManager) }
        return SPMCoverage(data: data)
    }
}

struct SPMCoverageData: Decodable {
    let files: [SPMCoverageFile]
    
    func filteringFiles(withFiles files: [String], fileManager: FileManager) -> SPMCoverageData {
        let files = self.files.filter { files.contains($0.filename) }.map { $0.byRemovingPath(path: fileManager.currentDirectoryPath) }
        return SPMCoverageData(files: files)
    }
}

struct SPMCoverageFile: Decodable {
    let filename: String
    let summary: SPMCoverageSummary
    
    func byRemovingPath(path: String) -> SPMCoverageFile {
        return SPMCoverageFile(filename: filename.deletingPrefix(path), summary: summary)
    }
}

struct SPMCoverageSummary: Decodable {
    private let lines: Lines
    
    var count: Int {
        return lines.count
    }
    
    var covered: Int {
        return lines.covered
    }
    
    var percent: Float {
        return lines.percent
    }
    
    struct Lines: Decodable, Equatable {
        let count: Int
        let covered: Int
        let percent: Float
    }
}

private extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard hasPrefix(prefix) else { return self }
        return String(dropFirst(prefix.count))
    }
}
