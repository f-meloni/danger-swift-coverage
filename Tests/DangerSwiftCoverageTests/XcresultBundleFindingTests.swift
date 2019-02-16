@testable import DangerSwiftCoverage
import XCTest

final class XcresultBundleFindingTests: XCTestCase {
    func testReturnsTheCorrectPath() throws {
        let stubbedFileManager = StubbedFileManager()
        stubbedFileManager.stubbedAttributesOfItemBlock = {
            $0 == "derived/Logs/Test/1.xcresult" ? [.modificationDate: Date(timeIntervalSince1970: 0)] : [.modificationDate: Date(timeIntervalSince1970: 1)]
        }
        stubbedFileManager.stubbedContentOfDirectoryBlock = { _ in
            ["1.xcresult", "2.xcresult"]
        }

        XCTAssertEqual(try XcresultBundleFinder.findXcresultFile(derivedDataFolder: "derived", fileManager: stubbedFileManager), "derived/Logs/Test/2.xcresult")
    }
}
