import Foundation

@objc public class BuildInfo: NSObject {
    @objc public func getBuildInfo() -> [String: Any] {
        let bundle = Bundle.main
        let info = bundle.infoDictionary
        
        // Improved Debug Detection for iOS
        var isDebug = false
        #if DEBUG
        isDebug = true
        #endif
        
        // Fallback check for debug: check if a debugger can be attached
        if !isDebug {
            var address = [CChar](repeating: 0, count: Int(MAXPATHLEN))
            if getenv("DYLD_INSERT_LIBRARIES") != nil || isatty(STDERR_FILENO) != 0 {
                isDebug = true
            }
        }
        
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
        
        // Improved Name Detection
        let displayName = info?["CFBundleDisplayName"] as? String
        let bundleName = info?["CFBundleName"] as? String
        let executableName = info?["CFBundleExecutable"] as? String
        
        let finalName = displayName ?? bundleName ?? executableName ?? ""
        
        return [
            "baseUrl": "",
            "packageName": bundle.bundleIdentifier ?? "",
            "basePackageName": bundle.bundleIdentifier ?? "",
            "displayName": finalName,
            "name": finalName,
            "version": info?["CFBundleShortVersionString"] as? String ?? "",
            "versionCode": info?["CFBundleVersion"] as? String ?? "",
            "debug": isDebug,
            "buildDate": buildDate,
            "installDate": installDate,
            "buildType": isDebug ? "debug" : "release",
            "flavor": "" // iOS doesn't have a native flavor concept at runtime
        ]
    }
}
