import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // Retrieve the API key from Info.plist
    let googleMapsAPIKey = Bundle.main.object(forInfoDictionaryKey: "GoogleMapsAPIKey") as? String

    // Check if the key was retrieved successfully and provide it to GMSServices
    if let apiKey = googleMapsAPIKey {
        GMSServices.provideAPIKey(apiKey)
    } else {
        fatalError("Google Maps API key not found in Info.plist. Please make sure it's set up correctly.")
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
