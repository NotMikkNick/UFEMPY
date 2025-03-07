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
    apiKey: 'AIzaSyDvfVPyO_LeXAK8PyEzw4G0U_JiZbXtgZM',
    appId: '1:201354427562:web:e24e145b870f8af21a24d3',
    messagingSenderId: '201354427562',
    projectId: 'todo-7c90f',
    authDomain: 'todo-7c90f.firebaseapp.com',
    storageBucket: 'todo-7c90f.firebasestorage.app',
    measurementId: 'G-Q1PEBPHVCQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD3hAIckyilACxpa_jewCJ8FtFwvj4LUtc',
    appId: '1:201354427562:android:582e1ea5c5b1ff611a24d3',
    messagingSenderId: '201354427562',
    projectId: 'todo-7c90f',
    storageBucket: 'todo-7c90f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA-M5laJhDep_bKpZt0K8_UWtNxdXVBUWA',
    appId: '1:201354427562:ios:5e5ccffb15302b731a24d3',
    messagingSenderId: '201354427562',
    projectId: 'todo-7c90f',
    storageBucket: 'todo-7c90f.firebasestorage.app',
    iosBundleId: 'com.marwinraabe.uwuploy.uwuployyy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA-M5laJhDep_bKpZt0K8_UWtNxdXVBUWA',
    appId: '1:201354427562:ios:5e5ccffb15302b731a24d3',
    messagingSenderId: '201354427562',
    projectId: 'todo-7c90f',
    storageBucket: 'todo-7c90f.firebasestorage.app',
    iosBundleId: 'com.marwinraabe.uwuploy.uwuployyy',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDvfVPyO_LeXAK8PyEzw4G0U_JiZbXtgZM',
    appId: '1:201354427562:web:8297a5695004ce6d1a24d3',
    messagingSenderId: '201354427562',
    projectId: 'todo-7c90f',
    authDomain: 'todo-7c90f.firebaseapp.com',
    storageBucket: 'todo-7c90f.firebasestorage.app',
    measurementId: 'G-02ZPSJV32L',
  );
}
