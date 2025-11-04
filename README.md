# Flutter Google Maps iOS Integration Demo

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)](https://flutter.dev/)
[![iOS](https://img.shields.io/badge/iOS-14.0+-black.svg)](https://www.apple.com/ios/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A professional demonstration of Google Maps integration in Flutter with **specialized iOS configuration**. This project showcases native iOS setup, location services implementation, and custom map widgets.

## 🎯 Project Context

This code sample represents key contributions I made to a **private GIS application project**. Since the original project is private, I've isolated and refined the Google Maps integration component to demonstrate:

- ✅ **Native iOS Configuration** - Proper setup of Google Maps for iOS
- ✅ **Location Permission Handling** - iOS-specific permission requests
- ✅ **Custom Map Widgets** - Reusable, production-ready components
- ✅ **Best Practices** - Secure API key management and error handling

## 🎥 Demo Video

> **Note:** The video demonstrates the original GIS application running with this Google Maps integration.

https://drive.google.com/file/d/1_Molho-zS5ojjqP28m-YdkOxagyMvmGD/view?usp=sharing

*To add your video:*
1. Upload your demo video to GitHub (drag & drop in an issue or discussion)
2. Replace `YOUR_VIDEO_ID_HERE` with the actual asset ID from GitHub
3. Alternatively, you can link to YouTube, Vimeo, or Google Drive

Or place your video file in a `demo/` folder:
```
demo/
  └── app_demo.mp4
```

## ✨ Features

### 📍 Interactive Location Picker
- Tap-to-select location on map
- Automatic current location detection
- Real-time coordinate display
- Visual marker feedback

### 📌 Read-Only Map Display
- Display saved locations
- Non-interactive view for data presentation
- Clean, consistent UI design

### 🔐 Secure Configuration
- API keys stored in `.xcconfig` files (excluded from git)
- Environment-based configuration
- Production-ready security practices

### 📱 iOS Native Integration
- Proper `Info.plist` permissions
- Google Maps SDK initialization in `AppDelegate`
- iOS 14.0+ compatibility

## 🏗️ Technical Implementation

### iOS Configuration

#### 1. **Podfile** (`ios/Podfile`)
```ruby
platform :ios, '14.0'

use_frameworks!
use_modular_headers!

target 'Runner' do
  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
end
```

#### 2. **AppDelegate.swift** (`ios/Runner/AppDelegate.swift`)
```swift
import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let googleMapsAPIKey = Bundle.main.object(forInfoDictionaryKey: "GoogleMapsAPIKey") as? String
    
    if let apiKey = googleMapsAPIKey {
        GMSServices.provideAPIKey(apiKey)
    } else {
        fatalError("Google Maps API key not found in Info.plist")
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

#### 3. **Info.plist** Configuration
Essential iOS permissions for location services:
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs access to your location to show it on the map.</string>

<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>This app needs your location to provide location-based features.</string>

<key>GoogleMapsAPIKey</key>
<string>$(GOOGLE_MAPS_API_KEY)</string>
```

#### 4. **MyKeys.xcconfig** (Secure Key Storage)
```
GOOGLE_MAPS_API_KEY=YOUR_API_KEY_HERE
```

### Custom Widgets

#### **PickLocationMap** Widget
Interactive map for selecting locations with:
- Automatic current location fetch
- Tap gesture handling
- Permission management
- Marker placement

#### **ReadOnlyMap** Widget
Display-only map component for:
- Showing saved locations
- Data visualization
- Non-interactive presentation

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0+)
- Xcode 14+
- CocoaPods
- Google Maps API Key ([Get one here](https://developers.google.com/maps/documentation/ios-sdk/get-api-key))

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/YOUR_USERNAME/flutter-google-maps-showcase.git
cd flutter-google-maps-showcase
```

2. **Install dependencies**
```bash
flutter pub get
cd ios && pod install && cd ..
```

3. **Configure Google Maps API Key**

Create/edit `ios/Flutter/MyKeys.xcconfig`:
```
GOOGLE_MAPS_API_KEY=YOUR_ACTUAL_API_KEY_HERE
```

⚠️ **Important:** Add `MyKeys.xcconfig` to `.gitignore` to keep your key secure!

4. **Update Xcode Configuration**

In Xcode, ensure `MyKeys.xcconfig` is imported in your build configurations:
- Open `ios/Runner.xcodeproj`
- Select Runner target → Build Settings
- Verify that Debug/Release configurations include `MyKeys.xcconfig`

5. **Run the app**
```bash
flutter run
```

## 📦 Dependencies

```yaml
dependencies:
  google_maps_flutter: ^2.12.3  # Google Maps integration
  geolocator: ^14.0.2           # Location services
  geocoding: ^4.0.0              # Address lookup (optional)
  get: ^4.7.2                    # State management
```

## 🔧 Project Structure

```
lib/
├── main.dart                          # App entry point & demo UI
└── widgets/
    ├── pick_location_map.dart         # Interactive map widget
    └── read_only_map.dart             # Display-only map widget

ios/
├── Podfile                            # iOS dependencies
├── Runner/
│   ├── AppDelegate.swift              # Google Maps initialization
│   └── Info.plist                     # iOS permissions & config
└── Flutter/
    └── MyKeys.xcconfig                # Secure API key storage (gitignored)
```

## 🎓 What This Demonstrates

### Native iOS Skills
- ✅ Swift integration with Flutter
- ✅ iOS permission handling (`Info.plist`)
- ✅ CocoaPods dependency management
- ✅ Xcode project configuration

### Flutter Development
- ✅ Google Maps Flutter plugin implementation
- ✅ Custom reusable widget development
- ✅ Location services (Geolocator)
- ✅ State management
- ✅ Asynchronous operations

### Best Practices
- ✅ Secure API key management
- ✅ Error handling & null safety
- ✅ Clean code architecture
- ✅ Documentation & comments
- ✅ Production-ready configuration

## 🐛 Troubleshooting

### Issue: "Google Maps API key not found"
**Solution:** Ensure `MyKeys.xcconfig` exists and is properly configured in Xcode build settings.

### Issue: Location not showing
**Solution:** 
1. Check iOS Simulator → Features → Location → Custom Location
2. Verify location permissions in iOS Settings app
3. Ensure `Info.plist` has location permission strings

### Issue: Pod install fails
**Solution:**
```bash
cd ios
rm -rf Pods Podfile.lock
pod cache clean --all
pod install
```

## 📱 Testing on iOS Simulator

1. Open iOS Simulator
2. **Features** → **Location** → **Apple** (or custom location)
3. Run the app: `flutter run`
4. Grant location permissions when prompted

## 🤝 Original Project Contributions

This showcase is derived from a larger **private GIS application** where I was responsible for:

- 🏗️ **Native iOS integration** for Google Maps
- 🔧 **Fixing critical iOS build errors** related to Podfile and Xcode configuration
- 📍 **Implementing location-based features** including map picking, area calculation, and geocoding
- 🎨 **Designing reusable map widgets** used throughout the application
- 📱 **iOS-specific optimizations** for performance and user experience

### Technologies Used in Original Project:
- Flutter & Dart
- Google Maps (iOS & Android)
- RESTful API integration
- State management (GetX)
- Image handling & compression
- Secure authentication (JWT)

## 👨‍💻 About

Created by **Yash Nandwani** as a portfolio demonstration of Flutter iOS development skills.

**Contact:**
- GitHub: [@yashnandwanii](https://github.com/yashnandwanii)
- Email: yashnandwani47@gmail.com  

---

⭐ **If you find this helpful, please consider giving it a star!**

*This is a code sample demonstrating specific technical skills and is not intended for production use without further development.*
