import Foundation

public extension SSZipArchive {
    typealias ProgressHandler = (_ entry: String, _ zipInfo: unz_file_info, _ entryNumber: Int, _ total: Int) -> Void

    static func unzipFile(
        atPath sourcePath: String,
        toDirectory destinationPath: String,
        preserveAttributes: Bool = true,
        overwrite: Bool = true,
        nestedZipLevel: Int = 0,
        password: String? = nil,
        delegate: SSZipArchiveDelegate? = nil,
        progressHandler: ProgressHandler? = nil
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

    static func unzipFile(
        atPath sourcePath: String,
        toDirectory destinationPath: String,
        preserveAttributes: Bool = true,
        overwrite: Bool = true,
        symlinksValidWithin validSymlinksPath: String?,
        nestedZipLevel: Int = 0,
        password: String? = nil,
        delegate: SSZipArchiveDelegate? = nil,
        progressHandler: ProgressHandler? = nil
    ) throws {
        var error: NSError?

        __unzipFile(
            atPath: sourcePath,
            toDestination: destinationPath,
            preserveAttributes: preserveAttributes,
            overwrite: overwrite,
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
        progressHandler: ProgressHandler? = nil
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
        progressHandler: ProgressHandler? = nil
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
