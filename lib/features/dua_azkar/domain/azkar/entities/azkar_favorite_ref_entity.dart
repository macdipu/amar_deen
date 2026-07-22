import 'package:equatable/equatable.dart';

/// A favorited Azkar item reference (item id + the chapter it belongs to).
/// There's no "get azkar item by id" lookup in `muslim_data_flutter`, only
/// per-chapter, so favorited items must be re-fetched by chapter.
class AzkarFavoriteRefEntity extends Equatable {
  final int azkarItemId;
  final int chapterId;

  const AzkarFavoriteRefEntity({
    required this.azkarItemId,
    required this.chapterId,
  });

  @override
  List<Object> get props => [azkarItemId, chapterId];
}
