import 'package:flutter/material.dart';
import 'package:uwuployyy/core/models/id_model.dart';
import 'package:uwuployyy/core/services/firestore_service.dart';
import 'package:intl/intl.dart';
import 'package:uwuployyy/features/auth/screens/add_id_screen.dart';

class IdListScreen extends StatelessWidget {
  const IdListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('ID-Liste'),
      ),
      body: FutureBuilder<List<IdModel>>(
        future: firestoreService.getAllIds(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Fehler: ${snapshot.error}'));
          }
          final idList = snapshot.data;
          if (idList == null || idList.isEmpty) {
            return const Center(child: Text('Keine IDs gefunden'));
          }
          return ListView.builder(
            itemCount: idList.length,
            itemBuilder: (context, index) {
              final idData = idList[index];
              return ListTile(
                title: Text('ID: ${idData.id}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Verwendet: ${idData.isUsed ? 'Ja' : 'Nein'}'),
                    if (idData.lastAppOpen != null)
                      Text(
                        'Letzte App-Öffnung: ${DateFormat('dd.MM.yyyy HH:mm')
                            .format(idData.lastAppOpen!)}',
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddIdScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}