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
    apiKey: 'AIzaSyARtvUYyAmealefl9mH3jkgplookqxGe7s',
    appId: '1:226609296835:web:d78010172360193b22f976',
    messagingSenderId: '226609296835',
    projectId: 'fir-withflutter-ebfe0',
    authDomain: 'fir-withflutter-ebfe0.firebaseapp.com',
    storageBucket: 'fir-withflutter-ebfe0.appspot.com',
    measurementId: 'G-V1YBKNZBF3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCMECX9Q0GbYBfRqtv3GDwGTPVemKTEbiQ',
    appId: '1:226609296835:android:46841304b0219bdb22f976',
    messagingSenderId: '226609296835',
    projectId: 'fir-withflutter-ebfe0',
    storageBucket: 'fir-withflutter-ebfe0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCXbTkApkStnfQ6ESjT8Tki0yovRYOEdAY',
    appId: '1:226609296835:ios:50a68761c3af0c9522f976',
    messagingSenderId: '226609296835',
    projectId: 'fir-withflutter-ebfe0',
    storageBucket: 'fir-withflutter-ebfe0.appspot.com',
    iosBundleId: 'com.example.flutterWithFirebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCXbTkApkStnfQ6ESjT8Tki0yovRYOEdAY',
    appId: '1:226609296835:ios:c34c95c9cf19880722f976',
    messagingSenderId: '226609296835',
    projectId: 'fir-withflutter-ebfe0',
    storageBucket: 'fir-withflutter-ebfe0.appspot.com',
    iosBundleId: 'com.example.flutterWithFirebase.RunnerTests',
  );
}
