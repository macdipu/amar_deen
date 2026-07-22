import 'package:equatable/equatable.dart';

/// A top-level Azkar category (e.g. "Morning Azkar").
class AzkarCategoryEntity extends Equatable {
  final int id;
  final String name;

  const AzkarCategoryEntity({required this.id, required this.name});

  @override
  List<Object> get props => [id, name];
}
