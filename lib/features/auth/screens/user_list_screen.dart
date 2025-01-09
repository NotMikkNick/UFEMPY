import 'package:flutter/material.dart';
import 'package:uwuployyy/core/models/admin_user_model.dart';
import 'package:uwuployyy/core/services/firestore_service.dart';
import 'package:uwuployyy/features/admin/screens/edit_user_screen.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Benutzerliste'),
      ),
      body: FutureBuilder<List<AdminUserModel>>(
        future: firestoreService.getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Fehler: ${snapshot.error}'));
          }
          final userList = snapshot.data;
          if (userList == null || userList.isEmpty) {
            return const Center(child: Text('Keine Benutzer gefunden'));
          }
          return ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              final userData = userList[index];
              return ListTile(
                title: Text('ID: ${userData.id}'),
                subtitle: Text('E-Mail: ${userData.email}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditUserScreen(user: userData),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Benutzer löschen'),
                              content: Text('Möchtest du den Benutzer ${userData
                                  .id} wirklich löschen?'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Abbrechen'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text('Löschen'),
                                  onPressed: () async {
                                    await firestoreService.deleteUser(
                                        userData.userId);
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Benutzer gelöscht')),
                                      );
                                    }
                                    if (context.mounted) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}