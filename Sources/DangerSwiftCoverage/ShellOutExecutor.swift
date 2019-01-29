import ShellOut

protocol ShellOutExecuting {
    func execute(command: String) throws -> String
}

struct ShellOutExecutor: ShellOutExecuting {
    func execute(command: String) throws -> String {
        return try shellOut(to: command)
    }
}
