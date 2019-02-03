import Foundation

protocol XcodeBuildCoverageParsing {
    static func coverage(derivedDataFolder: String, files: [String], excludedTargets: [String]) throws -> Report
}

enum XcodeBuildCoverageParser: XcodeBuildCoverageParsing {
    static func coverage(derivedDataFolder: String, files: [String], excludedTargets: [String]) throws -> Report {
        return try coverage(derivedDataFolder: derivedDataFolder, files: files, excludedTargets: excludedTargets, coverageFileFinder: XcodeCoverageFileFinder.self, xcCovParser: XcCovJSONParser.self)
    }

    static func coverage(derivedDataFolder: String, files: [String], excludedTargets: [String], coverageFileFinder: XcodeCoverageFileFinding.Type, xcCovParser: XcCovJSONParsing.Type) throws -> Report {
        let coverageFile = try coverageFileFinder.coverageFile(derivedDataFolder: derivedDataFolder)

        let data = try xcCovParser.json(fromXCoverageFile: coverageFile)
        var coverage = try JSONDecoder().decode(XcodeBuildCoverage.self, from: data)
        coverage = coverage.filteringTargets(notOn: files, excludedTargets: excludedTargets)

        return Report(messages: ["Project coverage: \(coverage.percentageCoverage.description)%"],
                      sections: coverage.targets.map { ReportSection(fromTarget: $0) })
    }
}
