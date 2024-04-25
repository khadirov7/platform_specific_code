import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private let CHANNEL = "com.example.platform_specific_code/test"

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let methodChannel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: controller.binaryMessenger)

    methodChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
      switch call.method {
      case "getBatteryLevel":
        self.getBatteryLevel(result: result)
      case "getDeviceModel":
        self.getDeviceModel(result: result)
      default:
        result(FlutterMethodNotImplemented)
      }
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func getBatteryLevel(result: @escaping FlutterResult) {
    let device = UIDevice.current
    device.isBatteryMonitoringEnabled = true
    let batteryLevel = Int(device.batteryLevel * 100)

    if batteryLevel >= 0 {
      result(batteryLevel)
    } else {
      result(FlutterError(code: "UNAVAILABLE", message: "Battery level not available", details: nil))
    }
  }

  private func getDeviceModel(result: @escaping FlutterResult) {
    let isPad = UIDevice.current.userInterfaceIdiom == .pad
    let deviceModel = isPad ? "Tablet" : "Phone"
    result(deviceModel)
  }
}
