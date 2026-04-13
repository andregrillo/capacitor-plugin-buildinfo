import Foundation

@objc public class BuildInfo: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
}
