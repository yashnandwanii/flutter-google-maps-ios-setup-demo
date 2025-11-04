# Setup Guide

## Quick Start for Hiring Managers / Reviewers

If you want to quickly review this code without setting up the full environment:

1. **Review the Code Structure:**
   - `lib/widgets/` - Custom map widgets
   - `ios/Runner/AppDelegate.swift` - iOS native integration
   - `ios/Podfile` - iOS dependencies
   - `lib/main.dart` - Demo application

2. **Key Files to Review:**
   - iOS configuration in `ios/` folder
   - Custom widgets demonstrating Google Maps integration
   - README.md for full context

## Full Setup (For Running the App)

### Step 1: Prerequisites
```bash
# Check Flutter installation
flutter doctor

# Ensure you have:
# - Flutter SDK 3.0+
# - Xcode 14+
# - CocoaPods
```

### Step 2: Get Google Maps API Key

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing one
3. Enable "Maps SDK for iOS"
4. Create credentials → API Key
5. (Optional) Restrict the key to iOS apps

### Step 3: Configure API Key

```bash
# Copy the example config file
cp ios/Flutter/MyKeys.xcconfig.example ios/Flutter/MyKeys.xcconfig

# Edit the file and add your API key
# GOOGLE_MAPS_API_KEY=YOUR_ACTUAL_KEY_HERE
```

### Step 4: Install Dependencies

```bash
# Install Flutter dependencies
flutter pub get

# Install iOS dependencies
cd ios
pod install
cd ..
```

### Step 5: Run the App

```bash
# For iOS Simulator
flutter run

# For specific device
flutter run -d <device-id>
```

## Troubleshooting

### "No such module 'GoogleMaps'" Error

**Solution:**
```bash
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter pub get
flutter run
```

### Location Permission Issues

1. iOS Simulator: Features → Location → Custom Location
2. Real Device: Settings → Privacy → Location Services → Enable for the app

### Xcode Build Fails

1. Open `ios/Runner.xcworkspace` in Xcode (not .xcodeproj)
2. Clean Build Folder: Product → Clean Build Folder
3. Ensure deployment target is iOS 14.0+

## Video Demo Setup

To add your demo video to the README:

### Option 1: GitHub Assets (Recommended)
1. Go to your GitHub repo
2. Create a new Issue (or Discussion)
3. Drag and drop your video file
4. Copy the generated URL
5. Paste it in README.md where it says `YOUR_VIDEO_ID_HERE`

### Option 2: YouTube
1. Upload video to YouTube
2. Get the share link
3. Replace the GitHub assets link with your YouTube link

### Option 3: Google Drive / Dropbox
1. Upload video and make it publicly accessible
2. Get the shareable link
3. Add to README.md

## Project Structure Explained

```
flutter-google-maps-showcase/
│
├── lib/
│   ├── main.dart                    # Demo app entry point
│   └── widgets/
│       ├── pick_location_map.dart   # Interactive map widget
│       └── read_only_map.dart       # Display-only map
│
├── ios/
│   ├── Podfile                      # iOS dependencies (Platform 14.0)
│   ├── Runner/
│   │   ├── AppDelegate.swift        # Google Maps initialization
│   │   └── Info.plist               # Permissions & API key reference
│   └── Flutter/
│       ├── MyKeys.xcconfig           # Your API key (gitignored)
│       └── MyKeys.xcconfig.example   # Template for setup
│
├── README.md                         # Main documentation
├── SETUP.md                          # This file
└── .gitignore                        # Keeps secrets safe
```

## What Makes This iOS-Specific?

1. **AppDelegate.swift**: Native Swift code that initializes Google Maps SDK
2. **Info.plist**: iOS-specific permissions for location services
3. **Podfile**: CocoaPods configuration for iOS dependencies
4. **MyKeys.xcconfig**: iOS build configuration for secure key management

## Next Steps After Setup

1. Test the interactive map (tap to select location)
2. Test the save functionality
3. View the read-only map display
4. Review the code structure
5. Customize for your needs

---

**Questions?** Check the main [README.md](README.md) or open an issue on GitHub.
