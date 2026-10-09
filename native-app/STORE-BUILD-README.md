# MSA FBLA Store Build

This folder is the native-wrapper setup for the MSA FBLA app. The web app remains in `../app`.

## Current status

- Capacitor configuration is prepared.
- Android and iOS platform packages are not generated yet because this Windows workspace does not have Node, Android Studio, Android SDK, or Gradle installed.
- iOS release builds require macOS with Xcode and an Apple Developer account.

## Android setup

Install Node.js LTS and Android Studio. Then from this folder run:

```text
npm install
npx cap add android
npx cap sync android
npx cap open android
```

In Android Studio, create a signed release bundle (`.aab`) and upload it to Google Play Console.

## iOS setup

On a Mac with Xcode and an Apple Developer account:

```text
npm install
npx cap add ios
npx cap sync ios
npx cap open ios
```

In Xcode, set the bundle identifier to `org.msfta.fbla`, select the Apple Developer team, archive the app, and upload it to App Store Connect.

## Store prerequisites

- App icon and launch assets in store-required sizes
- Screenshots for phone/tablet listings
- Privacy policy URL
- Support contact and app description
- Google Play Console account
- Apple Developer account
- Firebase project and production security rules published
