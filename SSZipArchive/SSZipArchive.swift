import Foundation

public enum CompressionLevel: Int32 {
    case noCompression = 0
    case bestSpeed = 1
    case bestCompression = 9
    case `default` = -1
}

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

public extension SSZipArchive {
    typealias CreateZipProgressHandler = (_ entryNumber: UInt, _ total: UInt) -> Void

    static func createZipFile(
        atPath destinationPath: String,
        withContentsOfDirectory sourceDirectory: String,
        keepParentDirectory: Bool,
        compressionLevel: CompressionLevel = .default,
        encryption: ArchiveEncryption = .noEncryption,
        globalComment: String? = nil,
        progressHandler: CreateZipProgressHandler? = nil
    ) -> Bool {
        __createZipFile(
            atPath: destinationPath,
            withContentsOfDirectory: sourceDirectory,
            keepParentDirectory: keepParentDirectory,
            compressionLevel: compressionLevel.rawValue,
            password: encryption.password,
            aes: encryption.isAES,
            globalComment: globalComment,
            progressHandler: progressHandler
        )
    }

    static func createZipFile(
        atPath destinationPath: String,
        withFilesAtPaths sourcePaths: [String],
        withPassword password: String? = nil,
        withGlobalComment globalComment: String? = nil,
        progressHandler: CreateZipProgressHandler? = nil
    ) -> Bool {
        __createZipFile(
            atPath: destinationPath,
            withFilesAtPaths: sourcePaths,
            withPassword: password,
            withGlobalComment: globalComment,
            progressHandler: progressHandler
        )
    }
}

public extension SSZipArchive {
    typealias UnzipProgressHandler = (_ entry: String, _ zipInfo: unz_file_info, _ entryNumber: Int, _ total: Int) -> Void

    static func unzipFile(
        atPath sourcePath: String,
        toDirectory destinationPath: String,
        preserveAttributes: Bool = true,
        overwrite: Bool = true,
        symlinksValidWithin validSymlinksPath: String?,
        nestedZipLevel: Int = 0,
        password: String? = nil,
        delegate: SSZipArchiveDelegate? = nil,
        progressHandler: UnzipProgressHandler? = nil
    ) throws {
        var error: NSError?

        __unzipFile(
            atPath: sourcePath,
            toDestination: destinationPath,
            preserveAttributes: preserveAttributes,
            overwrite: overwrite,
            symlinksValidWithin: validSymlinksPath,
            nestedZipLevel: nestedZipLevel,
            password: password,
            error: &error,
            delegate: delegate,
            progressHandler: progressHandler,
            completionHandler: nil
        )

        if let error {
            throw error
        }
    }
}

public extension SSZipArchive {
    static func unzipFile(
        atPath sourcePath: String,
        toDirectory destinationPath: String,
        preserveAttributes: Bool = true,
        overwrite: Bool = true,
        nestedZipLevel: Int = 0,
        password: String? = nil,
        delegate: SSZipArchiveDelegate? = nil,
        progressHandler: UnzipProgressHandler? = nil
    ) throws {
        try unzipFile(
            atPath: sourcePath,
            toDirectory: destinationPath,
            preserveAttributes: preserveAttributes,
            overwrite: overwrite,
            symlinksValidWithin: destinationPath,
            nestedZipLevel: nestedZipLevel,
            password: password,
            delegate: delegate,
            progressHandler: progressHandler
        )
    }
}

public extension SSZipArchive {
    static func unzipFile(
        atPath sourcePath: String,
        toDirectory destinationPath: String,
        preserveAttributes: Bool = true,
        overwrite: Bool = true,
        nestedZipLevel: Int = 0,
        password: String? = nil,
        delegate: SSZipArchiveDelegate? = nil,
        progressHandler: UnzipProgressHandler? = nil
    ) async throws {
        try {
           try unzipFile(
                atPath: sourcePath,
                toDirectory: destinationPath,
                preserveAttributes: preserveAttributes,
                overwrite: overwrite,
                nestedZipLevel: nestedZipLevel,
                password: password,
                delegate: delegate,
                progressHandler: progressHandler
            )
        }()
    }

    static func unzipFile(
        atPath sourcePath: String,
        toDirectory destinationPath: String,
        preserveAttributes: Bool = true,
        overwrite: Bool = true,
        symlinksValidWithin validSymlinksPath: String?,
        nestedZipLevel: Int = 0,
        password: String? = nil,
        delegate: SSZipArchiveDelegate? = nil,
        progressHandler: UnzipProgressHandler? = nil
    ) async throws {
        try {
            try unzipFile(
                atPath: sourcePath,
                toDirectory: destinationPath,
                preserveAttributes: preserveAttributes,
                overwrite: overwrite,
                symlinksValidWithin: validSymlinksPath,
                nestedZipLevel: nestedZipLevel,
                password: password,
                delegate: delegate,
                progressHandler: progressHandler
            )
        }()
    }
}
