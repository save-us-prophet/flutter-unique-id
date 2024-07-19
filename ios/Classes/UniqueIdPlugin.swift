import Flutter
import UIKit
import KeychainAccess

public class UniqueIdPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "unique_id", binaryMessenger: registrar.messenger())
        let instance = UniqueIdPlugin()
        
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
            
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
            
        case "getUniqueId":
            result(getUniqueId())
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func getUniqueId() -> String {
        let keychain = Keychain(service: "com.shareinvest.unique_id")
        let key = "uniqueDeviceId"
        
        if let uniqueId = keychain[key] {
            print("Existing Device ID: \(uniqueId)")

            return uniqueId
        } else {
            let newUUID = UUID().uuidString
            
            keychain[key] = newUUID
            
            print("New Device ID: \(newUUID)")

            return newUUID
        }
    }
}
