# Auth Setup

Google and Apple sign-in wiring is configured in code and platform projects.

## Required credential files

1. Copy [android/app/google-services.json.example](android/app/google-services.json.example) to `android/app/google-services.json` and replace with your Firebase Android app config.
2. Copy [ios/Runner/GoogleService-Info.plist.example](ios/Runner/GoogleService-Info.plist.example) to `ios/Runner/GoogleService-Info.plist` and replace with your Firebase iOS app config.

## iOS URL scheme

1. Open `ios/Runner/GoogleService-Info.plist`.
2. Copy `REVERSED_CLIENT_ID` value.
3. Set `GOOGLE_REVERSED_CLIENT_ID` in:
   - [ios/Flutter/Debug.xcconfig](ios/Flutter/Debug.xcconfig)
   - [ios/Flutter/Release.xcconfig](ios/Flutter/Release.xcconfig)

## Apple Sign-In capability

`Runner.entitlements` is already configured and attached to the Runner target.
You must still enable "Sign In with Apple" in your Apple Developer App ID for this bundle identifier.

## Verify

1. `flutter clean`
2. `flutter pub get`
3. Run Android and test Google sign-in.
4. Run iOS on device and test Google + Apple sign-in.
