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
        
        let df = ISO8601DateFormatter()
        
        var buildDate = ""
        if let path = bundle.path(forResource: "Info.plist", ofType: nil),
           let attr = try? FileManager.default.attributesOfItem(atPath: path),
           let modificationDate = attr[.modificationDate] as? Date {
            buildDate = df.string(from: modificationDate)
        }
        
        var installDate = ""
        if let urlDocument = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last,
           let attr = try? FileManager.default.attributesOfItem(atPath: urlDocument.path),
           let creationDate = attr[.creationDate] as? Date {
            installDate = df.string(from: creationDate)
        }
        
        let bundleName = info?["CFBundleName"] as? String ?? ""
        
        return [
            "baseUrl": "",
            "packageName": bundle.bundleIdentifier ?? "",
            "basePackageName": bundle.bundleIdentifier ?? "",
            "displayName": info?["CFBundleDisplayName"] as? String ?? bundleName,
            "name": bundleName,
            "version": info?["CFBundleShortVersionString"] as? String ?? "",
            "versionCode": info?["CFBundleVersion"] as? String ?? "",
            "debug": debug,
            "buildDate": buildDate,
            "installDate": installDate,
            "buildType": "",
            "flavor": ""
        ]
    }
}
