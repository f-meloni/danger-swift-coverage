public enum ExcludedTarget: Equatable {
    case exact(String)
    case regex(String)

    func matches(string: String) -> Bool {
        switch self {
        case let .exact(needle):
            return string == needle
        case let .regex(regex):
            return string.range(of: regex, options: .regularExpression) != nil
        }
    }
}
