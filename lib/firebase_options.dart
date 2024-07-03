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
    apiKey: 'AIzaSyBmng5CfjKRW9o39ZZVAgjSgO58fRD10QI',
    appId: '1:1020633608364:web:5852ea451c6e11b08cef09',
    messagingSenderId: '1020633608364',
    projectId: 'keepnote-2feb9',
    authDomain: 'keepnote-2feb9.firebaseapp.com',
    storageBucket: 'keepnote-2feb9.appspot.com',
    measurementId: 'G-HY06K5J6XR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCFi8n-rhb80qR6ccGxzP_dYQqBCC6_ByQ',
    appId: '1:1020633608364:android:9f919d17350781c48cef09',
    messagingSenderId: '1020633608364',
    projectId: 'keepnote-2feb9',
    storageBucket: 'keepnote-2feb9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCiM0X8een8NEI19IQJWwPyLrswHy9vqls',
    appId: '1:1020633608364:ios:072bf1b1af63283e8cef09',
    messagingSenderId: '1020633608364',
    projectId: 'keepnote-2feb9',
    storageBucket: 'keepnote-2feb9.appspot.com',
    iosBundleId: 'com.nuclieus.keepnote',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCiM0X8een8NEI19IQJWwPyLrswHy9vqls',
    appId: '1:1020633608364:ios:072bf1b1af63283e8cef09',
    messagingSenderId: '1020633608364',
    projectId: 'keepnote-2feb9',
    storageBucket: 'keepnote-2feb9.appspot.com',
    iosBundleId: 'com.nuclieus.keepnote',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBmng5CfjKRW9o39ZZVAgjSgO58fRD10QI',
    appId: '1:1020633608364:web:72b433c955e2b2e58cef09',
    messagingSenderId: '1020633608364',
    projectId: 'keepnote-2feb9',
    authDomain: 'keepnote-2feb9.firebaseapp.com',
    storageBucket: 'keepnote-2feb9.appspot.com',
    measurementId: 'G-4RZYGR92KQ',
  );
}
