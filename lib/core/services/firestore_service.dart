import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uwuployyy/core/models/user_model.dart';
import 'package:uwuployyy/core/models/id_model.dart';
import 'package:uwuployyy/core/models/admin_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> isValidId(String id) async {
    final doc = await _firestore.collection('validIds').doc(id).get();
    if (!doc.exists) {
      return false; // ID existiert nicht
    }
    final data = doc.data() as Map<String, dynamic>;
    final idModel = IdModel(id: doc.id,
        isUsed: data['isUsed'],
        lastAppOpen: data['lastAppOpen']?.toDate());
    return !idModel.isUsed; // ID ist gültig, wenn sie nicht verwendet wurde
  }

  Future<void> createUser(UserModel user) async {
    await _firestore.collection('users').doc(user.userId).set({
      'id': user.id,
      'email': user.email,
      'userId': user.userId,
      'isAdmin': user.isAdmin,
    });
    await _firestore.collection('validIds').doc(user.id).update(
        {'isUsed': true});
  }

  Future<void> addValidId(String id) async {
    await _firestore.collection('validIds').doc(id).set({
      'isUsed': false,
      'lastAppOpen': null, // Hinzugefügtes Feld
    });
  }

  Future<UserModel?> getUser(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (!doc.exists) {
      return null;
    }
    return UserModel(
      id: doc.get('id') as String,
      email: doc.get('email') as String,
      userId: doc.get('userId') as String,
      isAdmin: doc.get('isAdmin') as bool,
    );
  }

  Future<List<IdModel>> getAllIds() async {
    final snapshot = await _firestore.collection('validIds').get();
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return IdModel(id: doc.id,
          isUsed: data['isUsed'],
          lastAppOpen: data['lastAppOpen']?.toDate());
    }).toList();
  }

  Future<void> updateLastAppOpen(String id) async {
    await _firestore.collection('validIds').doc(id).update(
        {'lastAppOpen': DateTime.now()});
  }

  Future<void> deleteId(String id) async {
    await _firestore.collection('validIds').doc(id).delete();
  }

  Future<List<AdminUserModel>> getAllUsers() async {
    final snapshot = await _firestore.collection('users').get();
    return snapshot.docs.map((doc) =>
        AdminUserModel(id: doc.get('id'),
            email: doc.get('email'),
            userId: doc.get('userId'))).toList();
  }

  Future<void> deleteUser(String userId) async {
    await _firestore.collection('users').doc(userId).delete();
    final user = _auth.currentUser;
    if (user != null && user.uid == userId) {
      await user.delete();
    }
  }

  Future<void> updateUser(String userId, String newEmail) async {
    await _firestore.collection('users').doc(userId).update(
        {'email': newEmail});
  }
}