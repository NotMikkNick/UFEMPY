import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String userId;

  const UserModel({
    required this.id,
    required this.email,
    required this.userId,
  });

  @override
  List<Object?> get props => [id, email, userId];
}