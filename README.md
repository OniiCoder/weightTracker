# Weight Tracker

A Flutter application that lets users track weight data. 

- [See a Demo of the app functionalities](https://drive.google.com/uc?export=view&id=18Jxz4uqMiwpw1gkUysD4iZVPAslzhgqr)

The app uses the following:

- Firebase Auth for authentication.
- Firebase Cloud Firestore for realtime database
- SharedPreferences for persisting user authentication data on device to remain authenticated even when app is terminated until the user logout
- Flutter Bloc for state management

## Running The App

- Clone this repo
- run: `flutter pub get` to get the packages setup
- run: ` flutter pub run build_runner watch --delete-conflicting-outputs` to auto-generate the necessary bloc files.

That's all; you can launch the app!

Created by Oniicode.
