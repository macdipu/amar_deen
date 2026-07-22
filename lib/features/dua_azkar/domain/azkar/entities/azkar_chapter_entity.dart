import 'package:equatable/equatable.dart';

/// A chapter within an Azkar category.
class AzkarChapterEntity extends Equatable {
  final int id;
  final int categoryId;
  final String categoryName;
  final String name;

  const AzkarChapterEntity({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.name,
  });

  @override
  List<Object> get props => [id, categoryId, categoryName, name];
}
