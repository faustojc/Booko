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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDwbaXaoJaD3JVjVBNvsvx6lL5NVqNmBAo',
    appId: '1:297322852317:android:a0ffef350b20f89d811034',
    messagingSenderId: '297322852317',
    projectId: 'booko-47249',
    storageBucket: 'booko-47249.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDgHbUqJWROb5javGz4E6dsA7_Rpc6wqIA',
    appId: '1:297322852317:ios:a9cc81efe8d4378e811034',
    messagingSenderId: '297322852317',
    projectId: 'booko-47249',
    storageBucket: 'booko-47249.appspot.com',
    iosBundleId: 'com.bscs.booko',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDgHbUqJWROb5javGz4E6dsA7_Rpc6wqIA',
    appId: '1:297322852317:ios:a9cc81efe8d4378e811034',
    messagingSenderId: '297322852317',
    projectId: 'booko-47249',
    storageBucket: 'booko-47249.appspot.com',
    iosBundleId: 'com.bscs.booko',
  );
}
