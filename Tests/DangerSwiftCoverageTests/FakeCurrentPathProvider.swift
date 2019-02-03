import Foundation

final class FakeCurrentPathProvider: FileManager {
    let fakePath = "/usr/franco"
    lazy var currentPathBlock: () -> String = { [unowned self] in
        self.fakePath
    }

    override var currentDirectoryPath: String {
        return currentPathBlock()
    }
}
