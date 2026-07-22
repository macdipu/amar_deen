import 'package:equatable/equatable.dart';

/// One of the 99 Names of Allah.
class NameOfAllahEntity extends Equatable {
  final int id;
  final String name;
  final String translation;
  final String transliteration;

  const NameOfAllahEntity({
    required this.id,
    required this.name,
    required this.translation,
    required this.transliteration,
  });

  @override
  List<Object> get props => [id, name, translation, transliteration];
}
