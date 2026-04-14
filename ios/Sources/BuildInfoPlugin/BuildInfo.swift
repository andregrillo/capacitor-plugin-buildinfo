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

        // Build Date: Use Info.plist modification date or fallback to process start time
        var buildDate = ""
        if let path = bundle.path(forResource: "Info.plist", ofType: nil),
           let attr = try? FileManager.default.attributesOfItem(atPath: path),
           let modificationDate = attr[.modificationDate] as? Date {
            buildDate = df.string(from: modificationDate)
        } else {
            // Fallback to process start time (app launch time)
            let startTime = ProcessInfo.processInfo.systemUptime
            let installDate = Date().addingTimeInterval(-startTime)
            buildDate = df.string(from: installDate)
        }

        // Install Date: Use first known install estimate from system uptime
        var installDateStr = ""
        let bootTime = ProcessInfo.processInfo.systemUptime
        let estimatedInstallDate = Date().addingTimeInterval(-bootTime)
        installDateStr = df.string(from: estimatedInstallDate)

        // Get the best available name: CFBundleDisplayName first, then CFBundleName, then bundleIdentifier
        let displayName = info?["CFBundleDisplayName"] as? String
        let bundleName = info?["CFBundleName"] as? String
        let identifier = bundle.bundleIdentifier ?? ""
        let name = displayName ?? bundleName ?? identifier

        // BuildType: Derive from DEBUG flag and configuration
        let buildType = debug ? "debug" : "release"

        // Flavor: Try to get from Info.plist or environment, fallback to empty
        let flavor = info?["OsFlavor"] as? String ?? ""

        return [
            "baseUrl": "",
            "packageName": bundle.bundleIdentifier ?? "",
            "basePackageName": bundle.bundleIdentifier ?? "",
            "displayName": displayName ?? bundleName ?? identifier,
            "name": name,
            "version": info?["CFBundleShortVersionString"] as? String ?? "",
            "versionCode": info?["CFBundleVersion"] as? String ?? "",
            "debug": debug,
            "buildDate": buildDate,
            "installDate": installDateStr,
            "buildType": buildType,
            "flavor": flavor
        ]
    }
}
