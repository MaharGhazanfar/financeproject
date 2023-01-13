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
    apiKey: 'AIzaSyCF_wEbGDQAeF7VR8yqPWMq6NkzTDrBvHY',
    appId: '1:770544390824:web:daed2353ab4457ad99a89d',
    messagingSenderId: '770544390824',
    projectId: 'installia-69978',
    authDomain: 'installia-69978.firebaseapp.com',
    storageBucket: 'installia-69978.appspot.com',
    measurementId: 'G-V49G9SPPJ3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBxJMxv0hZ55xOLmgvPizsDhlYK5WBh4rM',
    appId: '1:770544390824:android:799b42204e7dc4c799a89d',
    messagingSenderId: '770544390824',
    projectId: 'installia-69978',
    storageBucket: 'installia-69978.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBypBsp0L4fgUE7xk9QLezp6cy_rtB4H_w',
    appId: '1:770544390824:ios:b2f86d293c98dbb699a89d',
    messagingSenderId: '770544390824',
    projectId: 'installia-69978',
    storageBucket: 'installia-69978.appspot.com',
    iosClientId: '770544390824-9uc0hh1fo1v166kl7hk4irsabj8o0n52.apps.googleusercontent.com',
    iosBundleId: 'com.org.flutter.financeproject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBypBsp0L4fgUE7xk9QLezp6cy_rtB4H_w',
    appId: '1:770544390824:ios:f44677307db3dd7d99a89d',
    messagingSenderId: '770544390824',
    projectId: 'installia-69978',
    storageBucket: 'installia-69978.appspot.com',
    iosClientId: '770544390824-6uh5ffc9cujnvu23qr5pcphmut1umajd.apps.googleusercontent.com',
    iosBundleId: 'com.org.flutter.installmentProject',
  );
}