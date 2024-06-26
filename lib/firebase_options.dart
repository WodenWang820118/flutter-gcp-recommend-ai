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
    apiKey: 'AIzaSyCiT_TDXR8wQ47EQy7IBcu7SbTONrZsj_I',
    appId: '1:434270270013:web:d367777d270da116c33054',
    messagingSenderId: '434270270013',
    projectId: 'dummy-apps-418906',
    authDomain: 'dummy-apps-418906.firebaseapp.com',
    storageBucket: 'dummy-apps-418906.appspot.com',
    measurementId: 'G-CG6S9Z6JY6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDl_G72KKiKa-S4H_wyhSAbo125-tlYax0',
    appId: '1:434270270013:android:8cb5ccf92d60254ac33054',
    messagingSenderId: '434270270013',
    projectId: 'dummy-apps-418906',
    storageBucket: 'dummy-apps-418906.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDp9vrfPMYQ0wge2B70m1aMkO1Eon_hIEA',
    appId: '1:434270270013:ios:2b1cbef6f1364b5cc33054',
    messagingSenderId: '434270270013',
    projectId: 'dummy-apps-418906',
    storageBucket: 'dummy-apps-418906.appspot.com',
    iosBundleId: 'com.example.firstFlutterProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDp9vrfPMYQ0wge2B70m1aMkO1Eon_hIEA',
    appId: '1:434270270013:ios:2b1cbef6f1364b5cc33054',
    messagingSenderId: '434270270013',
    projectId: 'dummy-apps-418906',
    storageBucket: 'dummy-apps-418906.appspot.com',
    iosBundleId: 'com.example.firstFlutterProject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCiT_TDXR8wQ47EQy7IBcu7SbTONrZsj_I',
    appId: '1:434270270013:web:2f31bd7328d279f0c33054',
    messagingSenderId: '434270270013',
    projectId: 'dummy-apps-418906',
    authDomain: 'dummy-apps-418906.firebaseapp.com',
    storageBucket: 'dummy-apps-418906.appspot.com',
    measurementId: 'G-5VZWMVRHC0',
  );
}