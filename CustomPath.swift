import Danger
import DangerSwiftCoverage

let danger = Danger()

Coverage.xcodeBuildCoverage(.xcresultBundle("build/result.xcresult"), minimumCoverage: 50, excludedTargets: ["DangerSwiftCoverageTests.xctest"])
