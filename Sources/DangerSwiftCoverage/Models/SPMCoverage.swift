import Foundation

struct SPMCoverage: Decodable {
    let data: [SPMCoverageData]

    func filteringFiles(notOn files: [String]) -> SPMCoverage {
        let data = self.data.map { $0.filteringFiles(notOn: files) }
        return SPMCoverage(data: data)
    }
}

struct SPMCoverageData: Decodable {
    let files: [SPMCoverageFile]

    func filteringFiles(notOn files: [String]) -> SPMCoverageData {
        let files = self.files.filter { files.contains($0.filename) }
        return SPMCoverageData(files: files)
    }
}

struct SPMCoverageFile: Decodable {
    let filename: String
    let summary: SPMCoverageSummary
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
