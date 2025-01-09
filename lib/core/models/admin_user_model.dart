import 'package:equatable/equatable.dart';

class AdminUserModel extends Equatable {
  final String id; // Die vom Benutzer eingegebene ID
  final String email;
  final String userId; // Die eindeutige Benutzer-ID von Firebase Authentication

  const AdminUserModel({
    required this.id,
    required this.email,
    required this.userId,
  });

  @override
  List<Object?> get props => [id, email, userId];
}