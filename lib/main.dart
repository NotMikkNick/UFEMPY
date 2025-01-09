import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'firebase_options.dart';

void main() async {
  //Stellt sicher, dass die Flutter-Widgets-Bindung initialisiert ist.
  WidgetsFlutterBinding.ensureInitialized();
  //Initialisiert Firebase mit den plattformspezifischen Optionen.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //Erzwingt die Ausrichtung der App im Hochformat.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //Startet die Haupt-App (UwUPloyApp).
  runApp(const UwUPloyApp());
}