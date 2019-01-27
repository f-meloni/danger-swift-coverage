import XCTest

import DangerSwiftCoverageTests

var tests = [XCTestCaseEntry]()
tests += DangerSwiftCoverageTests.allTests()
XCTMain(tests)