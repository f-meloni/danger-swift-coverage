import Danger
let danger = Danger()

Coverage.xcodeBuildCoverage(.custom("build/result"), minimumCoverage: 50, excludedTargets: [])
