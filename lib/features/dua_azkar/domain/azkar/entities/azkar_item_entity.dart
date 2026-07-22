import 'package:equatable/equatable.dart';

/// A single Azkar item (the actual dhikr text) within a chapter.
class AzkarItemEntity extends Equatable {
  final int id;
  final int chapterId;
  final String item;
  final String translation;
  final String reference;

  const AzkarItemEntity({
    required this.id,
    required this.chapterId,
    required this.item,
    required this.translation,
    required this.reference,
  });

  @override
  List<Object> get props => [id, chapterId, item, translation, reference];
}
