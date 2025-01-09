import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'package:uwuployyy/core/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final firestoreService = FirestoreService();
    final userData = await firestoreService.getUser(
        user.uid); // Benutzerdaten abrufen
    if (userData != null) {
      await firestoreService.updateLastAppOpen(
          userData.id); // Richtige ID verwenden
    }
  }
  runApp(const UwUPloyApp());
}