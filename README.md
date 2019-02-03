# DangerSwiftCoverage

Show the coverage of the modified/created files on your PRs.

![DangerSwiftCoverage](Images/DangerSwiftCoverage.png)

## Getting Started

- Add this to your `Dangerfile.swift`

```swift
import DangerSwiftCoverage // package: https://github.com/f-meloni/danger-swift-coverage

Coverage.xcodeBuildCoverage(derivedDataFolder: "Build", 
                            minimumCoverage: 50, 
                            excludedTargets: ["DangerSwiftCoverageTests.xctest"])
```

- Enable "Gather the Coverage" on Xcode 

![GatherCoverage](Images/GatherCoverage.png)

or, on your CI, execute: 
```bash
xcodebuild test -scheme DangerSwiftCoverage-Package -derivedDataPath Build/ -enableCodeCoverage YES
```

