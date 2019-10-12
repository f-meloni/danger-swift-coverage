@testable import DangerSwiftCoverage
import XCTest

final class XcodeCoverageFileFinderTests: XCTestCase {
    private var fileManager: StubbedFileManager!

    override func setUp() {
        super.setUp()
        fileManager = StubbedFileManager()
    }

    override func tearDown() {
        super.tearDown()
        fileManager = nil
    }

    func testItReturnsNilIfTheDirectoryDoesntContainAnXCovFile() {
        fileManager.stubbedContentOfDirectoryBlock = { _ in
            []
        }

        XCTAssertNil(XcodeCoverageFileFinder.coverageFile(xcresultBundlePath: "xcresultBundlePath", fileManager: fileManager))
    }

    func testItReturnsTheCorrectCoverageFile() throws {
        fileManager.stubbedContentOfDirectoryBlock = { fileName in
            fileName == "xcresultBundlePath" ? ["1_test"] : ["action.xccovreport"]
        }

        XCTAssertEqual(XcodeCoverageFileFinder.coverageFile(xcresultBundlePath: "xcresultBundlePath", fileManager: fileManager), "xcresultBundlePath/1_test/action.xccovreport")
    }
}
