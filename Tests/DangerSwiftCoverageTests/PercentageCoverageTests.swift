@testable import DangerSwiftCoverage
import XCTest

final class PercentageCoverageTests: XCTestCase {
    func testItReturnsTheCorrectPercentageValue() {
        let percentage = Percentage(lineCoverage: 0.69230769230769229)

        XCTAssertEqual(percentage.percentageCoverage, 69.23)
    }
}

struct Percentage: PercentageCoverage {
    var lineCoverage: Float
}
