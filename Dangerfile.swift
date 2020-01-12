import Danger
import DangerSwiftCoverage

let danger = Danger()

Coverage.xcodeBuildCoverage(.derivedDataFolder("build"), minimumCoverage: 50, excludedTargets: ["DangerSwiftCoverageTests.xctest"])
