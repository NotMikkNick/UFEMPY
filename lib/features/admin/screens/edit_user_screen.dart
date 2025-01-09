import 'package:flutter/material.dart';
import 'package:uwuployyy/core/models/admin_user_model.dart';
import 'package:uwuployyy/core/services/firestore_service.dart';

class EditUserScreen extends StatefulWidget {
  final AdminUserModel user;

  EditUserScreen({super.key, required this.user});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _emailController = TextEditingController();
  final _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.user.email;
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Benutzer bearbeiten'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'E-Mail',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final newEmail = _emailController.text.trim();
                if (newEmail.isNotEmpty) {
                  final allUsers = await _firestoreService.getAllUsers();
                  final isEmailTaken = allUsers.any((user) =>
                  user.email == newEmail && user.userId != widget.user
                      .userId); // Überprüfe, ob die E-Mail bereits von einem anderen Benutzer verwendet wird
                  if (!isEmailTaken) {
                    await _firestoreService.updateUser(
                        widget.user.userId, newEmail);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Benutzer aktualisiert')),
                      );
                    }
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('E-Mail bereits vergeben')),
                      );
                    }
                  }
                }
              },
              child: const Text('Speichern'),
            ),
          ],
        ),
      ),
    );
  }
}