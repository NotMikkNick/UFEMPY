import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uwuployyy/core/models/user_model.dart';
import 'package:uwuployyy/core/services/firestore_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
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
                Text('E-Mail: ${userData.email}'),
                const SizedBox(height: 16),
                Text('ID: ${userData.id}'),
              ],
            ),
          );
        },
      ),
    );
  }
}