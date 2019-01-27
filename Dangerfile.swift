import Danger 
import DangerXCodeSummary
import DangerSwiftCoverage

let danger = Danger()

let report = XCodeSummary(filePath: "report.json")
report.report()

Coverage.xcodeBuildCoverage(derivedDataFolder: "Build", minimumCoverage: 50)
