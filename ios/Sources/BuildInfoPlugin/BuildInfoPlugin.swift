import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(BuildInfoPlugin)
public class BuildInfoPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "BuildInfoPlugin"
    public let jsName = "BuildInfo"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "getBuildInfo", returnType: CAPPluginReturnPromise)
    ]
    private let implementation = BuildInfo()

    @objc func getBuildInfo(_ call: CAPPluginCall) {
        call.resolve(implementation.getBuildInfo())
    }
}
