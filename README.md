# Weight Tracker

A Flutter application that lets users track weight data. The app uses the following:

- Firebase Auth for authentication.
- Firebase Cloud Firestore for realtime database
- SharedPreferences for persisting user authentication data on device to remain authenticated even when app is terminated until the user logout
- Flutter Bloc for state management

## Running The App

Clone this repo run: `flutter pub get` to get the packages setup and then run: ` flutter pub run build_runner watch --delete-conflicting-outputs` to auto-generate the necessary bloc files. That's all; you can launch the app!

- [See a Demo of the app](https://flutter.dev/docs/get-started/codelab)

Created by Oniicode.
