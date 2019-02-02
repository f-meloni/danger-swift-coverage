# DangerSwiftCoverage

Show the coverage of the modified/created files on your PRs.

## Getting Started

- Add this to your `Dangerfile.swift`

```swift
import DangerSwiftCoverage // package: https://github.com/f-meloni/danger-swift-coverage

Coverage.xcodeBuildCoverage(derivedDataFolder: "Build", 
                            minimumCoverage: 50, 
                            excludedTargets: ["DangerSwiftCoverageTests.xctest"])
```

