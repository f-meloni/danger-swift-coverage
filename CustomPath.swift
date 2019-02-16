import Danger
import DangerSwiftCoverage

let danger = Danger()

Coverage.xcodeBuildCoverage(.custom("build/results"), minimumCoverage: 50, excludedTargets: ["DangerSwiftCoverageTests.xctest"])
