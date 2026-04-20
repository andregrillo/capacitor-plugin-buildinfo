import Foundation

@objc public class BuildInfo: NSObject {
    @objc public func getBuildInfo() -> [String: Any] {
        let bundle = Bundle.main
        let info = bundle.infoDictionary

        #if DEBUG
        let debug = true
        #else
        let debug = false
        #endif

        // Date formatter matching original Cordova plugin format
        let dfRFC3339 = DateFormatter()
        dfRFC3339.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dfRFC3339.locale = Locale(identifier: "en_US_POSIX")

        // Build Date: Use Info.plist modification date
        var buildDate = ""
        if let path = bundle.path(forResource: "Info.plist", ofType: nil),
           let attr = try? FileManager.default.attributesOfItem(atPath: path),
           let modificationDate = attr[.modificationDate] as? Date {
            buildDate = dfRFC3339.string(from: modificationDate)
        }

        // Install Date: Use document directory creation date
        var installDate = ""
        if let urlDocument = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last,
           let attr = try? FileManager.default.attributesOfItem(atPath: urlDocument.path),
           let creationDate = attr[.creationDate] as? Date {
            installDate = dfRFC3339.string(from: creationDate)
        }

        // Get bundle name from CFBundleName (matches original Cordova behavior)
        let bundleName = info?["CFBundleName"] as? String ?? ""
        let displayName = info?["CFBundleDisplayName"] as? String

        // BuildType and Flavor are Android-only in the original plugin
        // Leaving them empty for iOS as per original implementation

        if debug {
            NSLog("BuildInfo packageName    : \"%@\"", bundle.bundleIdentifier ?? "")
            NSLog("BuildInfo basePackageName: \"%@\"", bundle.bundleIdentifier ?? "")
            NSLog("BuildInfo displayName    : \"%@\"", displayName ?? bundleName)
            NSLog("BuildInfo name           : \"%@\"", bundleName)
            NSLog("BuildInfo version        : \"%@\"", info?["CFBundleShortVersionString"] as? String ?? "")
            NSLog("BuildInfo versionCode    : \"%@\"", info?["CFBundleVersion"] as? String ?? "")
            NSLog("BuildInfo debug          : %@", debug ? "YES" : "NO")
            NSLog("BuildInfo buildType       : \"%@\"", "")
            NSLog("BuildInfo buildDate      : \"%@\"", buildDate)
            NSLog("BuildInfo installDate    : \"%@\"", installDate)
            NSLog("BuildInfo flavor         : \"%@\"", "")
        }

        return [
            "baseUrl": "",
            "packageName": bundle.bundleIdentifier ?? "",
            "basePackageName": bundle.bundleIdentifier ?? "",
            "displayName": displayName ?? bundleName,
            "name": bundleName,
            "version": info?["CFBundleShortVersionString"] as? String ?? "",
            "versionCode": info?["CFBundleVersion"] as? String ?? "",
            "debug": debug,
            "buildDate": buildDate,
            "installDate": installDate,
            "buildType": "",  // Android Only
            "flavor": ""      // Android Only
        ]
    }
}