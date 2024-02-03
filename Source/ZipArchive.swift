import Foundation
#if canImport(ZipArchive_ObjC)
import ZipArchive_ObjC
#endif

public enum ZipArchive {}

public extension ZipArchive {
    typealias ZipArchiveDelegate = SSZipArchiveDelegate

    static func isFilePasswordProtected(atPath path: String) -> Bool {
        SSZipArchive.isFilePasswordProtected(atPath: path)
    }

    static func isPasswordValidForArchive(atPath path: String, password: String) throws -> Bool {
        var error: NSError?
        let isValid = SSZipArchive.isPasswordValidForArchive(atPath: path, password: password, error: &error)
        if let error {
            throw error
        }
        return isValid
    }

    static func payloadSizeForArchive(atPath path: String) throws -> Int {
        var error: NSError?
        let size = SSZipArchive.payloadSizeForArchive(atPath: path, error: &error)
        if let error {
            throw error
        }
        return size.intValue
    }

    static func readGlobalCommentOfArchive(atPath path: String) throws -> String? {
        try SSZipArchive.readGlobalCommentOfArchive(atPath: path)
    }
}

public extension ZipArchive {
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
        SSZipArchive.__createZipFile(
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
        SSZipArchive.__createZipFile(
            atPath: destinationPath,
            withFilesAtPaths: sourcePaths,
            withPassword: password,
            withGlobalComment: globalComment,
            progressHandler: progressHandler
        )
    }
}

public extension ZipArchive {
    typealias UnzipProgressHandler = (_ entry: String, _ zipInfo: unz_file_info, _ entryNumber: Int, _ total: Int) -> Void

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
    ) throws {
        var error: NSError?

        SSZipArchive.__unzipFile(
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
