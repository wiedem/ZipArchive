//
//  ViewController.swift
//  SwiftExample
//
//  Created by Sean Soper on 10/23/15.
//
//

import UIKit

#if UseCarthage
    import ZipArchive
#else
    import SSZipArchive
#endif

class ViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var globalCommentField: UITextField!
    @IBOutlet weak var zipButton: UIButton!
    @IBOutlet weak var unzipButton: UIButton!
    @IBOutlet weak var hasPasswordButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!

    @IBOutlet weak var file1: UILabel!
    @IBOutlet weak var file2: UILabel!
    @IBOutlet weak var file3: UILabel!
    @IBOutlet weak var info: UILabel!

    var samplePath: String!
    var zipPath: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        samplePath = Bundle.main.bundleURL.appendingPathComponent("Sample Data").path
        print("Sample path:", samplePath!)
        
        resetPressed(resetButton)
    }

    // MARK: IBAction

    @IBAction func zipPressed(_: UIButton) {
        zipPath = tempZipPath()
        print("Zip path:", zipPath!)
        let password = passwordField.text ?? ""
        let globalComment = globalCommentField.text ?? nil

        let encryption: ArchiveEncryption = !password.isEmpty ? .winZipAES(password) : .noEncryption

        let success = SSZipArchive.createZipFile(
            atPath: zipPath!,
            withContentsOfDirectory: samplePath,
            keepParentDirectory: false,
            encryption: encryption,
            globalComment: globalComment
        )

        if success {
            print("Success zip")
            info.text = "Success zip"
            unzipButton.isEnabled = true
            hasPasswordButton.isEnabled = true
        } else {
            print("No success zip")
            info.text = "No success zip"
        }
        resetButton.isEnabled = true
    }

    @IBAction func unzipPressed(_: UIButton) {
        guard let zipPath = self.zipPath else {
            return
        }

        guard let unzipPath = tempUnzipPath() else {
            return
        }
        print("Unzip path:", unzipPath)
        
        let password = passwordField.text ?? ""

        do {
            try SSZipArchive.unzipFile(
                atPath: zipPath,
                toDirectory: unzipPath,
                nestedZipLevel: 1,
                password: !password.isEmpty ? password : nil
            )

            let comment = try? SSZipArchive.readGlobalCommentOfArchive(atPath: zipPath)

            print("Success unzip - global comment: \(comment ?? "<n/a>")")
            info.text = "Success unzip - global comment: \(comment ?? "<n/a>")"
        } catch {
            print("No success unzip: \(error)")
            info.text = "No success unzip: \(error)"
            return
        }

        var items: [String]
        do {
            items = try FileManager.default.contentsOfDirectory(atPath: unzipPath)
        } catch {
            return
        }

        for (index, item) in items.enumerated() {
            switch index {
            case 0:
                file1.text = item
            case 1:
                file2.text = item
            case 2:
                file3.text = item
            default:
                print("Went beyond index of assumed files")
            }
        }

        unzipButton.isEnabled = false
    }

    @IBAction func hasPasswordPressed(_: UIButton) {
        guard let zipPath = zipPath else {
            return
        }
        let success = SSZipArchive.isFilePasswordProtected(atPath: zipPath)
        if success {
            print("Yes, it's password protected.")
            info.text = "Yes, it's password protected."
        } else {
            print("No, it's not password protected.")
            info.text = "No, it's not password protected."
        }
    }

    @IBAction func resetPressed(_: UIButton) {
        file1.text = ""
        file2.text = ""
        file3.text = ""
        info.text = ""
        zipButton.isEnabled = true
        unzipButton.isEnabled = false
        hasPasswordButton.isEnabled = false
        resetButton.isEnabled = false
    }

    // MARK: Private

    func tempZipPath() -> String {
        var path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        path += "/\(UUID().uuidString).zip"
        return path
    }

    func tempUnzipPath() -> String? {
        var path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        path += "/\(UUID().uuidString)"
        let url = URL(fileURLWithPath: path)

        do {
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        } catch {
            return nil
        }
        return url.path
    }
    
}
