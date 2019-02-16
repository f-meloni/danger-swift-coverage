import XCTest

extension CoverageTests {
    static let __allTests = [
        ("testItSendsAFailMessageIfFailsToParseTheXcodeBuildCoverage", testItSendsAFailMessageIfFailsToParseTheXcodeBuildCoverage),
        ("testItSendsTheCorrectParametersToTheSPMCoverageParser", testItSendsTheCorrectParametersToTheSPMCoverageParser),
        ("testItSendsTheCorrectParametersToTheXcodeBuildCoverageParser", testItSendsTheCorrectParametersToTheXcodeBuildCoverageParser),
        ("testItSendsTheCorrectParametersToTheXcodeBuildCoverageParserWhenTheXcresultBundlePathIsCustom", testItSendsTheCorrectParametersToTheXcodeBuildCoverageParserWhenTheXcresultBundlePathIsCustom),
        ("testItSendsTheCorrectReportToDangerForSPM", testItSendsTheCorrectReportToDangerForSPM),
        ("testItSendsTheCorrectReportToDangerForXCodebuild", testItSendsTheCorrectReportToDangerForXCodebuild),
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
        ("testItReturnsTheCorrectCoverageFile", testItReturnsTheCorrectCoverageFile),
    ]
}

extension XcresultBundleFindingTests {
    static let __allTests = [
        ("testReturnsTheCorrectPath", testReturnsTheCorrectPath),
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
            testCase(XcresultBundleFindingTests.__allTests),
        ]
    }
#endif
