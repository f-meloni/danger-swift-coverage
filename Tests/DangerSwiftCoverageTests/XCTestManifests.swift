import XCTest

extension CoverageTests {
    static let __allTests = [
        ("testItSendsAFailMessageIfFailsToParseTheXcodeBuildCoverage", testItSendsAFailMessageIfFailsToParseTheXcodeBuildCoverage),
        ("testItSendsTheCorrectParametersToTheXcodeBuildCoverageParser", testItSendsTheCorrectParametersToTheXcodeBuildCoverageParser),
        ("testItSendsTheCorrectRepoToDanger", testItSendsTheCorrectRepoToDanger),
    ]
}

extension PercentageCoverageTests {
    static let __allTests = [
        ("testItReturnsTheCorrectPercentageValue", testItReturnsTheCorrectPercentageValue),
    ]
}

extension SPMCoverageParserTests {
    static let __allTests = [
        ("testItDecodesTheJSONCorrectly", testItDecodesTheJSONCorrectly),
    ]
}

extension XcCovJSONTests {
    static let __allTests = [
        ("testItExectuesTheCorrectCommand", testItExectuesTheCorrectCommand),
    ]
}

extension XcodeBuildCoverageParserTests {
    static let __allTests = [
        ("testItFiltersTheEmptyTargets", testItFiltersTheEmptyTargets),
        ("testItFiltersTheExcludedTarget", testItFiltersTheExcludedTarget),
        ("testItParsesTheJSONCorrectly", testItParsesTheJSONCorrectly),
        ("testItReturnsTheCoverageWhenThereAreNoTargets", testItReturnsTheCoverageWhenThereAreNoTargets),
    ]
}

extension XcodeCoverageFileFinderTests {
    static let __allTests = [
        ("testItFailsIfTheDirectoryDoesntContainAnXCovFile", testItFailsIfTheDirectoryDoesntContainAnXCovFile),
        ("testItFailsIfTheDirectoryDoesntContainAnXCResultFile", testItFailsIfTheDirectoryDoesntContainAnXCResultFile),
        ("testItReturnsTheCorrectCoverageFile", testItReturnsTheCorrectCoverageFile),
    ]
}

#if !os(macOS)
    public func __allTests() -> [XCTestCaseEntry] {
        return [
            testCase(CoverageTests.__allTests),
            testCase(PercentageCoverageTests.__allTests),
            testCase(SPMCoverageParserTests.__allTests),
            testCase(XcCovJSONTests.__allTests),
            testCase(XcodeBuildCoverageParserTests.__allTests),
            testCase(XcodeCoverageFileFinderTests.__allTests),
        ]
    }
#endif
