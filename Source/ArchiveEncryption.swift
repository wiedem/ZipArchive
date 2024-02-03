public enum ArchiveEncryption {
    case noEncryption
    case winZipAES(String)
    case pkware(String)
}

extension ArchiveEncryption {
    var password: String? {
        switch self {
        case let .pkware(password), let .winZipAES(password):
            return password
        case .noEncryption:
            return nil
        }
    }

    var isAES: Bool {
        if case .winZipAES = self {
            return true
        }
        return false
    }
}
