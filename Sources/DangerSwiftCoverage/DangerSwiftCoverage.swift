import Danger
import Foundation

public enum Coverage {
    public static func xcodeBuildCoverage(derivedDataFolder: String, minimumCoverage: Float, excludedTargets: [String] = []) {
        xcodeBuildCoverage(derivedDataFolder: derivedDataFolder, minimumCoverage: minimumCoverage, excludedTargets: excludedTargets, fileManager: .default, xcodeBuildCoverageParser: XcodeBuildCoverageParser.self, danger: Danger())
    }

    static func xcodeBuildCoverage(derivedDataFolder: String, minimumCoverage: Float, excludedTargets: [String], fileManager: FileManager, xcodeBuildCoverageParser: XcodeBuildCoverageParsing.Type, danger: DangerDSL) {
        let paths = modifiedFilesAbsolutePaths(fileManager: fileManager, danger: danger)

        do {
            let report = try xcodeBuildCoverageParser.coverage(derivedDataFolder: derivedDataFolder, files: paths, excludedTargets: excludedTargets)
            sendReport(report, minumumCoverage: minimumCoverage, danger: danger)
        } catch {
            danger.fail("Failed to get the coverage - Error: \(error.localizedDescription)")
        }
    }

    public static func spmCoverage(spmCoverageFolder: String = ".build/debug/codecov", minimumCoverage: Float) {
        spmCoverage(spmCoverageFolder: spmCoverageFolder, minimumCoverage: minimumCoverage, spmCoverageParser: SPMCoverageParser.self, fileManager: .default, danger: Danger())
    }

    static func spmCoverage(spmCoverageFolder: String, minimumCoverage: Float, spmCoverageParser: SPMCoverageParsing.Type, fileManager: FileManager, danger: DangerDSL) {
        do {
            let report = try spmCoverageParser.coverage(spmCoverageFolder: spmCoverageFolder, files: modifiedFilesAbsolutePaths(fileManager: fileManager, danger: danger))
            sendReport(report, minumumCoverage: minimumCoverage, danger: danger)
        } catch {
            danger.fail("Failed to get the coverage - Error: \(error.localizedDescription)")
        }
    }

    private static func modifiedFilesAbsolutePaths(fileManager: FileManager, danger: DangerDSL) -> [String] {
        return (danger.git.createdFiles + danger.git.modifiedFiles).map { fileManager.currentDirectoryPath + "/" + $0 }
    }

    private static func sendReport(_ report: Report, minumumCoverage: Float, danger: DangerDSL) {
        report.messages.forEach { danger.message($0) }

        report.sections.forEach {
            danger.markdown($0.markdown(minimumCoverage: minumumCoverage))
        }
    }
}
