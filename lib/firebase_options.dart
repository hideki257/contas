
// File generated by FlutLab.
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for iOS - '
          'try to add using FlutLab Firebase Configuration',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'it not supported by FlutLab yet, but you can add it manually',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'it not supported by FlutLab yet, but you can add it manually',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'it not supported by FlutLab yet, but you can add it manually',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAO8ZKkre9p12h7qiM7BDsMr03Ff_AsKP4',
    appId: '1:586021145029:android:fb9ac0826f7e288c06e3ac',
    messagingSenderId: '586021145029',
    projectId: 'contas-53559',
    storageBucket: 'contas-53559.appspot.com'
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAREcmpNNIy_BbS_11Q6SCFfYKmCA4WPYQ',
    authDomain: 'contas-53559.firebaseapp.com',
    projectId: 'contas-53559',
    storageBucket: 'contas-53559.appspot.com',
    messagingSenderId: '586021145029',
    appId: '1:586021145029:web:c363121b0259e68306e3ac'
  );
}