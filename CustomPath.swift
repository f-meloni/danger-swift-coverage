import Danger
import DangerSwiftCoverage

let danger = Danger()

Coverage.xcodeBuildCoverage(.xcresultBundle("build/results.xcresult"), minimumCoverage: 50, excludedTargets: ["DangerSwiftCoverageTests.xctest"])
