import 'package:flutter/material.dart';
import 'package:uwuployyy/features/auth/screens/profile_screen.dart';
import 'package:uwuployyy/features/auth/screens/id_list_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uwuployyy/core/services/firestore_service.dart';
import 'package:uwuployyy/core/models/user_model.dart';
import 'package:uwuployyy/features/auth/screens/user_list_screen.dart'; // Korrekter Import

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Willkommen'),
      ),
      body: FutureBuilder<UserModel?>(
        future: firestoreService.getUser(user!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Fehler: ${snapshot.error}'));
          }
          final userData = snapshot.data;
          if (userData == null) {
            return const Center(child: Text('Benutzerdaten nicht gefunden'));
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Willkommen!'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                  child: const Text('Zum Profil'),
                ),
                const SizedBox(height: 20),
                if (userData.isAdmin)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/idList');
                    },
                    child: const Text('Zur ID-Liste'),
                  ),
                const SizedBox(height: 20),
                if (userData
                    .isAdmin) // Nur anzeigen, wenn der Benutzer ein Administrator ist
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/userList');
                    },
                    child: const Text('Zur Benutzerliste'),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}