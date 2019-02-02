struct Report {
    let messages: [String]
    let sections: [ReportSection]
}

struct ReportSection {
    let titleText: String?
    let items: [ReportFile]
}

extension ReportSection {
    init(fromTarget target: Target) {
        self.titleText = "\(target.name): Coverage: \(target.percentageCoverage)"
        self.items = target.files.map { ReportFile(fileName: $0.name, coverage: $0.percentageCoverage) }
    }
}

extension ReportSection {
    init?(from spm: SPMCoverage) {
        self.titleText = nil
        self.items = spm.data.flatMap { $0.files.map { ReportFile(fileName: $0.filename, coverage: $0.summary.percent) } }  
    }
}

extension ReportSection {
    func markdown(minimumCoverage: Float) -> String {
        var markdown = titleText != nil ? "## \(titleText!)\n" : ""

        markdown += """
        | File | Coverage ||
        | --- | --- | --- |\n
        """

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
