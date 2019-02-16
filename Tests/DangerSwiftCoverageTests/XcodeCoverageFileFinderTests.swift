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

    func testItFailsIfTheDirectoryDoesntContainAnXCovFile() {
        fileManager.stubbedContentOfDirectoryBlock = { _ in
            []
        }

        XCTAssertThrowsError(try XcodeCoverageFileFinder.coverageFile(xcresultBundlePath: "xcresultBundlePath", fileManager: fileManager)) { error in
            XCTAssertEqual(error.localizedDescription, "Could not find the xccovreport file")
        }
    }

    func testItReturnsTheCorrectCoverageFile() throws {
        fileManager.stubbedContentOfDirectoryBlock = { fileName in
            fileName == "xcresultBundlePath" ? ["1_test"] : ["action.xccovreport"]
        }

        XCTAssertEqual(try XcodeCoverageFileFinder.coverageFile(xcresultBundlePath: "xcresultBundlePath", fileManager: fileManager), "xcresultBundlePath/1_test/action.xccovreport")
    }
}
