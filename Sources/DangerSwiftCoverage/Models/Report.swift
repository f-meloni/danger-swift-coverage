struct Report {
    let messages: [String]
    let sections: [ReportSection]
}

struct ReportSection {
    let titleText: String
    let items: [ReportFile]
}

extension ReportSection {
    func markdown(minimumCoverage: Float) -> String {
        var markdown = "## \(titleText)\n"
        
        markdown += items.map {
            "\($0.fileName) | \($0.coverage)% | \($0.coverage > minimumCoverage ? "✅" : "❌")\n"
            }.joined()
        
        return markdown
    }
}

struct ReportFile {
    let fileName: String
    let coverage: Float
}
