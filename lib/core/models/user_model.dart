import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id; // Die vom Benutzer eingegebene ID
  final String email;
  final String userId; // Die eindeutige Benutzer-ID von Firebase Authentication
  final bool isAdmin; // Gibt an, ob der Benutzer ein Administrator ist

  const UserModel({
    required this.id,
    required this.email,
    required this.userId,
    this.isAdmin = false, // Standardmäßig ist ein neuer Benutzer kein Administrator
  });

  @override
  List<Object?> get props => [id, email, userId, isAdmin];
}