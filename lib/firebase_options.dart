// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

import 'package:flutter_dotenv/flutter_dotenv.dart';

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
  static String androidApiKey = dotenv.env['ANDROID_API_KEY'] ?? '';
  static String iosApiKey = dotenv.env['IOS_API_KEY'] ?? '';

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
    apiKey: 'AIzaSyCuga5Bw8p2APcsU_W3bU-8J6CH5C7gdvc',
    appId: '1:474540806298:web:c96bcb4bf4924365e38f23',
    messagingSenderId: '474540806298',
    projectId: 'jollibee-f24c4',
    authDomain: 'jollibee-f24c4.firebaseapp.com',
    storageBucket: 'jollibee-f24c4.appspot.com',
    measurementId: 'G-3PX7RVMPMX',
  );

  static FirebaseOptions android = FirebaseOptions(
    apiKey: androidApiKey,
    appId: '1:474540806298:android:fd024c39dd6e57a4e38f23',
    messagingSenderId: '474540806298',
    projectId: 'jollibee-f24c4',
    storageBucket: 'jollibee-f24c4.appspot.com',
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: iosApiKey,
    appId: '1:474540806298:ios:e3652db1cf8d6570e38f23',
    messagingSenderId: '474540806298',
    projectId: 'jollibee-f24c4',
    storageBucket: 'jollibee-f24c4.appspot.com',
    iosBundleId: 'com.jollibee',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDKXIXEP5KH21mDiJiM5bZzmCuwtCkcFXU',
    appId: '1:474540806298:ios:10a0c641dfe7e623e38f23',
    messagingSenderId: '474540806298',
    projectId: 'jollibee-f24c4',
    storageBucket: 'jollibee-f24c4.appspot.com',
    iosBundleId: 'com.jollibee.RunnerTests',
  );
}
