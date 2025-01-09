import 'package:equatable/equatable.dart';

class IdModel extends Equatable {
  final String id;
  final bool isUsed;

  const IdModel({
    required this.id,
    required this.isUsed,
  });

  @override
  List<Object?> get props => [id, isUsed];
}