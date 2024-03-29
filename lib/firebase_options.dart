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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAv8yCHBUYLazkuRhskPxNKAb5R2bwMEGI',
    appId: '1:209966601380:web:f264078b6b4291a9208231',
    messagingSenderId: '209966601380',
    projectId: 'runningappseminar',
    authDomain: 'runningappseminar.firebaseapp.com',
    databaseURL: 'https://runningappseminar-default-rtdb.firebaseio.com',
    storageBucket: 'runningappseminar.appspot.com',
    measurementId: 'G-EB0D3ML6EZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAvxRPfnBmVFxWJSos27P_i5FbwtzXD9MM',
    appId: '1:209966601380:android:d694492f0dd1622f208231',
    messagingSenderId: '209966601380',
    projectId: 'runningappseminar',
    databaseURL: 'https://runningappseminar-default-rtdb.firebaseio.com',
    storageBucket: 'runningappseminar.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBQSepDiAUA0kGyk5zBmvqk3OfW3WQTcXA',
    appId: '1:209966601380:ios:c8249ebf4697bcf0208231',
    messagingSenderId: '209966601380',
    projectId: 'runningappseminar',
    databaseURL: 'https://runningappseminar-default-rtdb.firebaseio.com',
    storageBucket: 'runningappseminar.appspot.com',
    iosBundleId: 'com.example.runningAppFlutter',
  );
}
