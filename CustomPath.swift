import Danger
import DangerSwiftCoverage

let danger = Danger()

Coverage.xcodeBuildCoverage(.custom("build/result"), minimumCoverage: 50, excludedTargets: ["DangerSwiftCoverageTests.xctest"])
