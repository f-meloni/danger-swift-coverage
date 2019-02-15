import Foundation

struct XcodeBuildCoverage: Decodable, PercentageCoverage {
    let coveredLines: Int
    let executableLines: Int
    let lineCoverage: Float
    let targets: [Target]

    func filteringTargets(notOn files: [String], excludedTargets: [String]) -> XcodeBuildCoverage {
        let targets = self.targets.map { $0.filteringFiles(notOn: files) }.filter { !$0.files.isEmpty && !excludedTargets.contains($0.name) }
        return XcodeBuildCoverage(coveredLines: coveredLines, executableLines: executableLines, lineCoverage: lineCoverage, targets: targets)
    }
}

struct Target: Decodable, PercentageCoverage {
    let coveredLines: Int
    let executableLines: Int
    let lineCoverage: Float
    let name: String
    let files: [File]

    func filteringFiles(notOn files: [String]) -> Target {
        let files = self.files.filter { files.contains($0.path) }
        return Target(coveredLines: coveredLines, executableLines: executableLines, lineCoverage: lineCoverage, name: name, files: files)
    }
}

struct File: Decodable, PercentageCoverage {
    let coveredLines: Int
    let executableLines: Int
    let lineCoverage: Float
    let path: String
    let name: String
}

protocol PercentageCoverage {
    var lineCoverage: Float { get }
    var percentageCoverage: Float { get }
}

extension PercentageCoverage {
    var percentageCoverage: Float {
        let percentageCoverage = lineCoverage * 100

        // Round the float to 2 decimal places
        return (percentageCoverage * 100).rounded() / 100
    }
}
