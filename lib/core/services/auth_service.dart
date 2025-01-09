import 'package:firebase_auth/firebase_auth.dart';
import 'package:uwuployyy/core/models/user_model.dart';
import 'package:uwuployyy/core/services/firestore_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String id,
  }) async {
    try {
      final UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final UserModel user = UserModel(
        id: id,
        email: email,
        userId: userCredential.user!.uid,
      );

      await _firestoreService.createUser(user);
    } catch (e) {
      rethrow;
    }
  }
}