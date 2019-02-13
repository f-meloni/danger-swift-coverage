import Foundation

final class StubbedFileManager: FileManager {
    let fakePath = "/usr/franco"
    lazy var currentPathBlock: () -> String = { [unowned self] in
        self.fakePath
    }

    var stubbedContentOfDirectoryBlock: ((String) -> [String])?

    override var currentDirectoryPath: String {
        return currentPathBlock()
    }

    override func contentsOfDirectory(atPath path: String) throws -> [String] {
        if let stubbedContentOfDirectoryBlock = stubbedContentOfDirectoryBlock {
            return stubbedContentOfDirectoryBlock(path)
        } else {
            return try super.contentsOfDirectory(atPath: path)
        }
    }
}
