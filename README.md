# SSZipArchive

ZipArchive is a simple utility class for zipping and unzipping files on iOS, macOS and tvOS.

- Unzip zip files;
- Unzip password protected zip files;
- Unzip AES encrypted zip files;
- Create zip files;
- Create large (> 4.3Gb) files;
- Create password protected zip files;
- Create AES encrypted zip files;
- Choose compression level;
- Zip-up NSData instances. (with a filename)

## Version 2.5.0+ Updates Minimum OS Versions

A key dependency of this project is the zlib library. zlib before version 1.2.12 allows memory corruption when deflating (i.e., when compressing) if the input has many distant matches according to [CVE-2018-25032](https://nvd.nist.gov/vuln/detail/cve-2018-25032).  

zlib 1.2.12 is included in macOS 10.15+ (with latest security patches), iOS 15.5+, tvOS 15.4+, watchOS 8.4+.  **As such, these OS versions will be the new minimums as of version 2.5.0 of ZipArchive.** 

If you need support for previous versions of ZipArchive for earlier OS support you can target an earlier version but know you will be using an unmaintained version of this library. 

We will not support versions of ZipArchive that use dependencies with known vulnerabilities. 

## Installation and Setup

*The main release branch is configured to support Objective-C and Swift 5+.*

SSZipArchive works on Xcode 12 and above, iOS 15.5 and above, tvOS 15.4 and above, macOS 10.15 and above, watchOS 8.4 and above.

### SPM
Add a Swift Package reference to https://github.com/wiedem/ZipArchive.git (SSZipArchive 3.0.0 and higher or main)

## Usage

```swift
import ZipArchive

let success = ZipArchive.createZipFile(
    atPath: zipPath,
    withContentsOfDirectory: sampleDataPath,
    keepParentDirectory: false
)

try ZipArchive.unzipFile(
    atPath: zipPath,
    toDirectory: unzipPath
)
```

## License

SSZipArchive is protected under the [MIT license](https://github.com/samsoffes/ssziparchive/raw/master/LICENSE) and our slightly modified version of [minizip-ng (formally minizip)](https://github.com/zlib-ng/minizip-ng) 3.0.6 is licensed under the [Zlib license](https://www.zlib.net/zlib_license.html).

## Acknowledgments

* Big thanks to *aish* for creating [ZipArchive](https://code.google.com/archive/p/ziparchive/). The project that inspired SSZipArchive.
* Thank you [@soffes](https://github.com/soffes) for the actual name of SSZipArchive.
* Thank you [@randomsequence](https://github.com/randomsequence) for implementing the creation support tech.
* Thank you [@johnezang](https://github.com/johnezang) for all his amazing help along the way.
* Thank you [@nmoinvaz](https://github.com/nmoinvaz) for minizip-ng (formally minizip), the core of ZipArchive.
* Thank you to [all the contributors](https://github.com/wiedem/ZipArchive/graphs/contributors).
