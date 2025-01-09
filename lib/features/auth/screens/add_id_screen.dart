import 'package:flutter/material.dart';
import 'package:uwuployyy/core/services/firestore_service.dart';

class AddIdScreen extends StatefulWidget {
  const AddIdScreen({super.key});

  @override
  State<AddIdScreen> createState() => _AddIdScreenState();
}

class _AddIdScreenState extends State<AddIdScreen> {
  final _idController = TextEditingController();
  final _firestoreService = FirestoreService();

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ID hinzufügen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(
                labelText: 'Neue ID',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final id = _idController.text.trim();
                if (id.isNotEmpty) {
                  final isValid = await _firestoreService.isValidId(id);
                  if (!isValid) {
                    await _firestoreService.addValidId(id);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('ID hinzugefügt')),
                      );
                    }
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('ID existiert bereits')),
                      );
                    }
                  }
                }
              },
              child: const Text('ID hinzufügen'),
            ),
          ],
        ),
      ),
    );
  }
}