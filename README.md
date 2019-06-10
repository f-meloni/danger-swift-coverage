# DangerSwiftCoverage

[Danger-Swift](https://github.com/danger/swift) plugin to show the coverage of the modified/created files.

![DangerSwiftCoverage](Images/DangerSwiftCoverage.png)

## Getting Started

### Install DangerSwiftCoverage
#### Swift Package Manager (More performant)
You can use a "full SPM" solution to install both `danger-swift` and `DangerSwiftCoverage`.

- Add to your `Package.swift`:

```swift
let package = Package(
    ...
    products: [
        ...
        .library(name: "DangerDeps", type: .dynamic, targets: ["DangerDependencies"]), // dev
        ...
    ],
    dependencies: [
        ...
        // Danger Plugins
        .package(url: "https://github.com/f-meloni/danger-swift-coverage", from: "0.1.0") // dev
        ...
    ],
    targets: [
        .target(name: "DangerDependencies", dependencies: ["Danger", "DangerSwiftCoverage"]), // dev
        ...
    ]
)
```

- Add the correct import to your `Dangerfile.swift`:
```swift
import DangerSwiftCoverage

Coverage.xcodeBuildCoverage(.derivedDataFolder("Build"), 
                            minimumCoverage: 50, 
                            excludedTargets: ["DangerSwiftCoverageTests.xctest"])
```

- Create a folder called `DangerDependencies` on `Sources` with an empty file inside like [Fake.swift](Sources/DangerDependencies/Fake.swift)
- To run `Danger` use `swift run danger-swift command`
- (Recommended) If you are using SPM to distribute your framework, use [Rocket](https://github.com/f-meloni/Rocket), or similar to comment out all the dev depencencies from your `Package.swift`.
This prevents the dev dependencies to be downloaded and compiled with your framework.

#### Marathon
- Add this to your `Dangerfile.swift`

```swift
import DangerSwiftCoverage // package: https://github.com/f-meloni/danger-swift-coverage

Coverage.xcodeBuildCoverage(.derivedDataFolder("Build"), 
                            minimumCoverage: 50, 
                            excludedTargets: ["DangerSwiftCoverageTests.xctest"])
```

- (Recommended) Cache the `~/.danger-swift` folder

### Gather Coverage

- Enable "Gather the Coverage" on Xcode 

![GatherCoverage](Images/GatherCoverage.png)

or, on your CI, execute: 
```bash
xcodebuild test -scheme DangerSwiftCoverage-Package -derivedDataPath Build/ -enableCodeCoverage YES
```

### Custom XCResultBundle path
If you are using the `-resultBundlePath` parameter on `xcodebuild` you will need to use:
```
Coverage.xcodeBuildCoverage(.xcresultBundle("Build/bundlePath"), 
                            minimumCoverage: 50, 
                            excludedTargets: ["DangerSwiftCoverageTests.xctest"])
```

### Swift Package Manager
From Swift 5.0 you can gather the coverage from SPM with the `--enable-code-coverage=true` flag
For SPM coverage add to your Dangerfile:

```swift
Coverage.spmCoverage(minimumCoverage: 50)
```

## License
This project is licensed under the terms of the MIT license. See the LICENSE file.
