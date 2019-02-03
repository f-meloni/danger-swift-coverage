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

- Enable "Gather the Coverage" on Xcode or run 
```bash
xcodebuild test -scheme DangerSwiftCoverage-Package -derivedDataPath Build/ -enableCodeCoverage YES
```
on your CI
