# Auth Setup

Auth is intentionally simplified to a single provider layer: Auth0 Universal Login.

## 1. Fill Auth0 app config in code

Open [lib/src/auth/auth0_config.dart](lib/src/auth/auth0_config.dart) and set:

- `domain`
- `clientId`
- `callbackScheme`

Use a lowercase callback scheme (example: `com.ostrack.ostrackapp`).

## 2. Match Android callback placeholders

Open [android/app/build.gradle.kts](android/app/build.gradle.kts) and make sure:

- `manifestPlaceholders["auth0Domain"]` equals your Auth0 domain
- `manifestPlaceholders["auth0Scheme"]` equals the same `callbackScheme` used in `auth0_config.dart`

## 3. Match iOS URL scheme

Open [ios/Runner/Info.plist](ios/Runner/Info.plist) and make sure `CFBundleURLSchemes` contains the same callback scheme from `auth0_config.dart`.

## 4. Configure Auth0 Application URIs

In your Auth0 application settings, set both Allowed Callback URLs and Allowed Logout URLs to include:

- Android: `SCHEME://YOUR_DOMAIN/android/com.ostrack.ostrack_app/callback`
- iOS: `SCHEME://YOUR_DOMAIN/ios/com.ostrack.ostrackApp/callback`

Replace `SCHEME` with your callback scheme and `YOUR_DOMAIN` with your Auth0 domain.

## 5. Enable social connections in Auth0

In Auth0, enable these connections for your app:

- Google (`google-oauth2`)
- Apple (`apple`)

## 6. Verify

1. `flutter clean`
2. `flutter pub get`
3. Run Android and sign in with Google.
4. Run iOS and sign in with Apple.
