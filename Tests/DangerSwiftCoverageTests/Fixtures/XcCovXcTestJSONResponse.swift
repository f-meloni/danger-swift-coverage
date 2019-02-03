let XcCovXcTestJSONResponse = """

{
	"coveredLines": 294,
	"lineCoverage": 0.50085178875638836,
	"targets": [{
		"coveredLines": 182,
		"lineCoverage": 0.43436754176610981,
		"files": [{
			"coveredLines": 6,
			"lineCoverage": 1,
			"path": "/Users/franco/Projects/swift/Sources/Danger/BitBucketServerDSL.swift",
			"functions": [{
				"coveredLines": 3,
				"lineCoverage": 1,
				"lineNumber": 61,
				"executionCount": 1,
				"name": "Danger.BitBucketServerMetadata.pullRequestID.getter : Swift.String",
				"executableLines": 3
			}, {
				"coveredLines": 3,
				"lineCoverage": 1,
				"lineNumber": 66,
				"executionCount": 1,
				"name": "Danger.BitBucketServerMetadata.repoSlug.getter : Swift.String",
				"executableLines": 3
			}],
			"name": "BitBucketServerDSL.swift",
			"executableLines": 6
		}, {
			"coveredLines": 0,
			"lineCoverage": 0,
			"path": "/Users/franco/Projects/swift/Sources/Danger/Danger.swift",
			"functions": [{
				"coveredLines": 0,
				"lineCoverage": 0,
				"lineNumber": 19,
				"executionCount": 0,
				"name": "",
				"executableLines": 43
			}, {
				"coveredLines": 0,
				"lineCoverage": 0,
				"lineNumber": 20,
				"executionCount": 0,
				"name": "implicit closure #1 : @autoclosure () throws -> Swift.Bool in Danger.DangerRunner.() -> Danger.DangerRunner(in _DA57A8538BDE0544FE0FD943A1DB0C2B).init() -> Danger.DangerRunner",
				"executableLines": 1
			}, {
				"coveredLines": 0,
				"lineCoverage": 0,
				"lineNumber": 66,
				"executionCount": 0,
				"name": "Danger.Danger() -> Danger.DangerDSL",
				"executableLines": 3
			}, {
				"coveredLines": 0,
				"lineCoverage": 0,
				"lineNumber": 75,
				"executionCount": 0,
				"name": "dump #1 () -> () in Danger.(dumpResultsAtExit in _DA57A8538BDE0544FE0FD943A1DB0C2B)(_: Danger.DangerRunner, path: Swift.String) -> ()",
				"executableLines": 18
			}],
			"name": "Danger.swift",
			"executableLines": 65
		}, {
			"coveredLines": 35,
			"lineCoverage": 0.92105263157894735,
			"path": "/Users/franco/Projects/swift/Sources/Danger/DangerDSL.swift",
			"functions": [{
				"coveredLines": 32,
				"lineCoverage": 1,
				"lineNumber": 32,
				"executionCount": 11,
				"name": "",
				"executableLines": 32
			}, {
				"coveredLines": 0,
				"lineCoverage": 0,
				"lineNumber": 71,
				"executionCount": 0,
				"name": "Danger.DangerDSL.runningOnBitbucketServer.getter : Swift.Bool",
				"executableLines": 3
			}, {
				"coveredLines": 3,
				"lineCoverage": 1,
				"lineNumber": 75,
				"executionCount": 3,
				"name": "Danger.DangerDSL.supportsSuggestions.getter : Swift.Bool",
				"executableLines": 3
			}],
			"name": "DangerDSL.swift",
			"executableLines": 38
		}, {
			"coveredLines": 5,
			"lineCoverage": 1,
			"path": "/Users/franco/Projects/swift/Sources/Danger/DangerResults.swift",
			"functions": [{
				"coveredLines": 5,
				"lineCoverage": 1,
				"lineNumber": 11,
				"executionCount": 2,
				"name": "",
				"executableLines": 5
			}],
			"name": "DangerResults.swift",
			"executableLines": 5
		}, {
			"coveredLines": 21,
			"lineCoverage": 0.48837209302325579,
			"path": "/Users/franco/Projects/swift/Sources/Danger/DangerUtils.swift",
			"functions": [{
				"coveredLines": 6,
				"lineCoverage": 0.29999999999999999,
				"lineNumber": 17,
				"executionCount": 3,
				"name": "Danger.DangerUtils.readFile(Swift.String) -> Swift.String",
				"executableLines": 20
			}],
			"name": "Report.swift",
			"executableLines": 113
		}],
		"name": "Danger.framework",
		"executableLines": 419,
		"buildProductPath": "/Users/franco/Projects/swift/Build/Build/Products/Debug/Danger.framework/Versions/A/Danger"
	}, {
		"coveredLines": 112,
		"lineCoverage": 0.66666666666666663,
		"files": [{
			"coveredLines": 34,
			"lineCoverage": 1,
			"path": "/Users/franco/Projects/swift/Sources/RunnerLib/Files Import/DangerFileGenerator.swift",
			"functions": [{
				"coveredLines": 1,
				"lineCoverage": 1,
				"lineNumber": 5,
				"executionCount": 4,
				"name": "",
				"executableLines": 1
			}, {
				"coveredLines": 20,
				"lineCoverage": 1,
				"lineNumber": 7,
				"executionCount": 4,
				"name": "RunnerLib.DangerFileGenerator.generateDangerFile(fromContent: Swift.String, fileName: Swift.String, logger: Logger.Logger) throws -> ()",
				"executableLines": 20
			}, {
				"coveredLines": 13,
				"lineCoverage": 1,
				"lineNumber": 11,
				"executionCount": 7,
				"name": "closure #1 (Swift.Optional<__C.NSTextCheckingResult>, __C.NSMatchingFlags, Swift.UnsafeMutablePointer<ObjectiveC.ObjCBool>) -> () in RunnerLib.DangerFileGenerator.generateDangerFile(fromContent: Swift.String, fileName: Swift.String, logger: Logger.Logger) throws -> ()",
				"executableLines": 13
			}],
			"name": "DangerFileGenerator.swift",
			"executableLines": 34
		}, {
			"coveredLines": 9,
			"lineCoverage": 1,
			"path": "/Users/franco/Projects/swift/Sources/RunnerLib/Files Import/ImportsFinder.swift",
			"functions": [{
				"coveredLines": 1,
				"lineCoverage": 1,
				"lineNumber": 4,
				"executionCount": 2,
				"name": "",
				"executableLines": 1
			}, {
				"coveredLines": 7,
				"lineCoverage": 1,
				"lineNumber": 6,
				"executionCount": 2,
				"name": "RunnerLib.ImportsFinder.findImports(inString: Swift.String) -> Swift.Array<Swift.String>",
				"executableLines": 7
			}, {
				"coveredLines": 1,
				"lineCoverage": 1,
				"lineNumber": 9,
				"executionCount": 2,
				"name": "closure #1 (__C.NSTextCheckingResult) -> Swift.String in RunnerLib.ImportsFinder.findImports(inString: Swift.String) -> Swift.Array<Swift.String>",
				"executableLines": 1
			}],
			"name": "ImportsFinder.swift",
			"executableLines": 9
		}, {
			"coveredLines": 5,
			"lineCoverage": 1,
			"path": "/Users/franco/Projects/swift/Sources/RunnerLib/HelpMessagePresenter.swift",
			"functions": [{
				"coveredLines": 5,
				"lineCoverage": 1,
				"lineNumber": 4,
				"executionCount": 1,
				"name": "static RunnerLib.HelpMessagePresenter.showHelpMessage(command: Swift.Optional<RunnerLib.DangerCommand>, logger: Logger.Logger) -> ()",
				"executableLines": 5
			}],
			"name": "HelpMessagePresenter.swift",
			"executableLines": 5
		}, {
			"coveredLines": 0,
			"lineCoverage": 0,
			"path": "/Users/franco/Projects/swift/Sources/RunnerLib/Runtime.swift",
			"functions": [{
				"coveredLines": 0,
				"lineCoverage": 0,
				"lineNumber": 9,
				"executionCount": 0,
				"name": "static RunnerLib.Runtime.getDangerfile() -> Swift.Optional<Swift.String>",
				"executableLines": 3
			}, {
				"coveredLines": 0,
				"lineCoverage": 0,
				"lineNumber": 10,
				"executionCount": 0,
				"name": "closure #1 (Swift.String) -> Swift.Bool in static RunnerLib.Runtime.getDangerfile() -> Swift.Optional<Swift.String>",
				"executableLines": 1
			}, {
				"coveredLines": 0,
				"lineCoverage": 0,
				"lineNumber": 23,
				"executionCount": 0,
				"name": "static RunnerLib.Runtime.getLibDangerPath() -> Swift.Optional<Swift.String>",
				"executableLines": 35
			}, {
				"coveredLines": 0,
				"lineCoverage": 0,
				"lineNumber": 34,
				"executionCount": 0,
				"name": "closure #1 (Swift.String) -> Swift.Bool in static RunnerLib.Runtime.getLibDangerPath() -> Swift.Optional<Swift.String>",
				"executableLines": 1
			}, {
				"coveredLines": 0,
				"lineCoverage": 0,
				"lineNumber": 44,
				"executionCount": 0,
				"name": "isTheDangerLibPath #1 (path: Swift.String) -> Swift.Bool in static RunnerLib.Runtime.getLibDangerPath() -> Swift.Optional<Swift.String>",
				"executableLines": 4
			}, {
				"coveredLines": 0,
				"lineCoverage": 0,
				"lineNumber": 46,
				"executionCount": 0,
				"name": "implicit closure #1 : @autoclosure () throws -> Swift.Bool in isTheDangerLibPath #1 (path: Swift.String) -> Swift.Bool in static RunnerLib.Runtime.getLibDangerPath() -> Swift.Optional<Swift.String>",
				"executableLines": 1
			}],
			"name": "Runtime.swift",
			"executableLines": 45
		}],
		"name": "RunnerLib.xctest",
		"executableLines": 168,
		"buildProductPath": "/Users/franco/Projects/swift/Build/Build/Products/Debug/RunnerLib.framework/Versions/A/RunnerLib"
	}],
	"executableLines": 587
}

"""
