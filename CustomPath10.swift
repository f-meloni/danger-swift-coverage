import Danger
import DangerSwiftCoverage

let danger = Danger()

Coverage.xcodeBuildCoverage(.xcresultBundle("build/results"), minimumCoverage: 50, excludedTargets: ["DangerSwiftCoverageTests.xctest"])
