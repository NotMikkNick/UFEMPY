import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uwuployyy/core/models/user_model.dart';
import 'package:uwuployyy/core/models/id_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> isValidId(String id) async {
    final doc = await _firestore.collection('validIds').doc(id).get();
    if (!doc.exists) {
      return false; // ID existiert nicht
    }
    final idModel = IdModel(id: doc.id, isUsed: doc.get('isUsed'));
    return !idModel.isUsed; // ID ist gültig, wenn sie nicht verwendet wurde
  }

  Future<void> createUser(UserModel user) async {
    await _firestore.collection('users').doc(user.userId).set({
      'id': user.id,
      'email': user.email,
      'userId': user.userId,
    });
    await _firestore.collection('validIds').doc(user.id).update(
        {'isUsed': true});
  }

  Future<void> addValidId(String id) async {
    await _firestore.collection('validIds').doc(id).set({
      'isUsed': false,
    });
  }
}