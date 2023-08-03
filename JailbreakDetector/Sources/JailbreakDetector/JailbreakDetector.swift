import Foundation
import UIKit

public struct JailbreakDetector {
    private init() {}
    
    public static func isJailbroken() -> Bool {
        /// Check existence of files or apps that are common for jailbroken devices
        let paths = [
            "/private/var/lib/cydia",
            "/private/var/tmp/cydia.log",
            "/private/var/mobile/Library/SBSettings/Themes",
            "/private/var/stash",
            "/private/var/lib/apt/",
            "/etc/apt",
            "/etc/ssh/sshd_config",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/usr/bin/ssh",
            "/usr/local/bin/cycript",
            "/usr/libexec/cydia/",
            "/usr/libexec/sftp-server",
            "/usr/libexec/ssh-keysign",
            "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
            "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
            "/Applications/JailbreakMe.app/",
            "/Applications/blackra1n.app/",
            "/Applications/Cydia.app",
            "/Applications/blackra1n.app",
            "/Applications/FakeCarrier.app",
            "/Applications/Icy.app",
            "/Applications/IntelliScreen.app",
            "/Applications/IntelliScreenx.app",
            "/Applications/MxTube.app",
            "/Applications/RockApp.app",
            "/Applications/SBSettings.app",
            "/Applications/WinterBoard.app",
            "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
            "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
            "/Library/MobileSubstrate/MobileSubstrate.dylib"
        ]
        for path in paths {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }

//        /// Check if the app can open Cydia's URL scheme
//        if let cydiaURL = URL(string: "cydia://package/com.example.package") {
//            if UIApplication.shared.canOpenURL(cydiaURL) {
//                return true
//            }
//        }
        
        /// Check for the presence of symbolic links that indicate a jailbreak
        let path = "/private/" + UUID().uuidString
        if symlink("/", path) == 0 {
            unlink(path)
            return true
        }
        
        /// Check Reading and writing in system directories (sandbox violation)
        let stringToWrite = "Jailbreak Test"
        do {
            try stringToWrite.write(
                toFile:"/private/JailbreakTest.txt",
                atomically: true,
                encoding: .utf8
            )
            /// Device is jailbroken
            return true
        } catch {
            return false
        }
    }
}
