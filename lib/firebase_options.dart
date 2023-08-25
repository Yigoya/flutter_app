// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDU0SMhWMFOmvpmtJQMoER8WKq_hqytXkk',
    appId: '1:424467029424:web:14a1263ab0f6d571148a75',
    messagingSenderId: '424467029424',
    projectId: 'charity-e5aed',
    authDomain: 'charity-e5aed.firebaseapp.com',
    storageBucket: 'charity-e5aed.appspot.com',
    measurementId: 'G-WM2G2V5YL4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCLfpYxgyA4t4PGOhz2DRVuc6ogcgPEb2U',
    appId: '1:424467029424:android:70ad02f0b5c4070a148a75',
    messagingSenderId: '424467029424',
    projectId: 'charity-e5aed',
    storageBucket: 'charity-e5aed.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD3-NVEDIdbqfO46PzHP9IQSeAVkLR2KLU',
    appId: '1:424467029424:ios:fb8acb8249dbd256148a75',
    messagingSenderId: '424467029424',
    projectId: 'charity-e5aed',
    storageBucket: 'charity-e5aed.appspot.com',
    iosClientId: '424467029424-acg3a5nm2teql03emv2thd3j6oa18bqk.apps.googleusercontent.com',
    iosBundleId: 'com.example.untitled',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD3-NVEDIdbqfO46PzHP9IQSeAVkLR2KLU',
    appId: '1:424467029424:ios:2d9571f5b3769724148a75',
    messagingSenderId: '424467029424',
    projectId: 'charity-e5aed',
    storageBucket: 'charity-e5aed.appspot.com',
    iosClientId: '424467029424-0snmg7cflsq88dh2i0p8jdcf4rkhqo21.apps.googleusercontent.com',
    iosBundleId: 'com.example.untitled.RunnerTests',
  );
}
