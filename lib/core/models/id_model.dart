import 'package:equatable/equatable.dart';

class IdModel extends Equatable {
  final String id;
  final bool isUsed;
  final DateTime? lastAppOpen; // Hinzugefügtes Feld

  const IdModel({
    required this.id,
    required this.isUsed,
    this.lastAppOpen, // Hinzugefügtes Feld
  });

  @override
  List<Object?> get props => [id, isUsed, lastAppOpen]; // Hinzugefügtes Feld
}