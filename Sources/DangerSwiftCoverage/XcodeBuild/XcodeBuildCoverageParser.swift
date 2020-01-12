import Foundation

protocol XcodeBuildCoverageParsing {
    static func coverage(xcresultBundlePath: String, files: [String], excludedTargets: [String], hideProjectCoverage: Bool) throws -> Report
}

enum XcodeBuildCoverageParser: XcodeBuildCoverageParsing {
    static func coverage(xcresultBundlePath: String, files: [String], excludedTargets: [String], hideProjectCoverage: Bool) throws -> Report {
        try coverage(xcresultBundlePath: xcresultBundlePath, files: files, excludedTargets: excludedTargets, hideProjectCoverage: hideProjectCoverage, xcCovParser: XcCovJSONParser.self)
    }

    static func coverage(xcresultBundlePath: String, files: [String], excludedTargets: [String], hideProjectCoverage: Bool = false, xcCovParser: XcCovJSONParsing.Type) throws -> Report {
        let data = try xcCovParser.json(fromXcresultFile: xcresultBundlePath)
        return try report(fromJson: data, files: files, excludedTargets: excludedTargets, hideProjectCoverage: hideProjectCoverage)
    }

    private static func report(fromJson data: Data, files: [String], excludedTargets: [String], hideProjectCoverage: Bool) throws -> Report {
        var coverage = try JSONDecoder().decode(XcodeBuildCoverage.self, from: data)
        coverage = coverage.filteringTargets(notOn: files, excludedTargets: excludedTargets)

        let targets = coverage.targets.map { ReportSection(fromTarget: $0) }
        let messages = !targets.isEmpty && !hideProjectCoverage ? ["Project coverage: \(coverage.percentageCoverage.description)%"] : []

        return Report(messages: messages, sections: targets)
    }
}
