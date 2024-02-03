#if canImport(ZipArchive_ObjC)
import ZipArchive_ObjC
#endif

public extension ZipArchive {
    static func unzipFile(
        atPath sourcePath: String,
        toDirectory destinationPath: String,
        preserveAttributes: Bool = true,
        overwrite: Bool = true,
        nestedZipLevel: Int = 0,
        password: String? = nil,
        delegate: ZipArchiveDelegate? = nil,
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
        delegate: ZipArchiveDelegate? = nil,
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
