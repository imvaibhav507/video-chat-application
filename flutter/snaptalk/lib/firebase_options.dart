// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyBz_ARHTKKyXGe8JJ2m0C62MAncUcHIUEg',
    appId: '1:148845706310:web:b4bd12f596b98eacca5e47',
    messagingSenderId: '148845706310',
    projectId: 'snap-talk-89f4a',
    authDomain: 'snap-talk-89f4a.firebaseapp.com',
    storageBucket: 'snap-talk-89f4a.appspot.com',
    measurementId: 'G-F0YWXRMCLM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDQg3E-DDLy6E7CBMAz08x8IoE6XWbvm8c',
    appId: '1:148845706310:android:37397afb025c214fca5e47',
    messagingSenderId: '148845706310',
    projectId: 'snap-talk-89f4a',
    storageBucket: 'snap-talk-89f4a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAb-3ctS5NlcY4SxJ0249wPqxt5uwuOnAk',
    appId: '1:148845706310:ios:7c920824c0493814ca5e47',
    messagingSenderId: '148845706310',
    projectId: 'snap-talk-89f4a',
    storageBucket: 'snap-talk-89f4a.appspot.com',
    iosBundleId: 'com.example.snaptalk',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAb-3ctS5NlcY4SxJ0249wPqxt5uwuOnAk',
    appId: '1:148845706310:ios:7c920824c0493814ca5e47',
    messagingSenderId: '148845706310',
    projectId: 'snap-talk-89f4a',
    storageBucket: 'snap-talk-89f4a.appspot.com',
    iosBundleId: 'com.example.snaptalk',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBz_ARHTKKyXGe8JJ2m0C62MAncUcHIUEg',
    appId: '1:148845706310:web:08225fbb28c00804ca5e47',
    messagingSenderId: '148845706310',
    projectId: 'snap-talk-89f4a',
    authDomain: 'snap-talk-89f4a.firebaseapp.com',
    storageBucket: 'snap-talk-89f4a.appspot.com',
    measurementId: 'G-0GFTWHC9L9',
  );
}
