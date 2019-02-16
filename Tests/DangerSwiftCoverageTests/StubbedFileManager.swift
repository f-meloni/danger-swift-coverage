import Foundation

final class StubbedFileManager: FileManager {
    let fakePath = "/usr/franco"
    lazy var currentPathBlock: () -> String = { [unowned self] in
        self.fakePath
    }

    var stubbedContentOfDirectoryBlock: ((String) -> [String])?
    var stubbedAttributesOfItemBlock: ((String) -> [FileAttributeKey: Any])?

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

    override func attributesOfItem(atPath path: String) throws -> [FileAttributeKey: Any] {
        return stubbedAttributesOfItemBlock?(path) ?? [.modificationDate: Date()]
    }
}
