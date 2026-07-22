import 'package:injectable/injectable.dart';
import 'package:muslim_data_flutter/muslim_data_flutter.dart' show Language;
import 'package:sqflite/sqflite.dart';

import '../entities/azkar_item_entity.dart';
import '../repositories/azkar_repository.dart';

/// Loads the user's favorited Azkar items. There's no "get azkar item by
/// id" lookup in `muslim_data_flutter`, only per-chapter, so this fetches
/// each distinct favorited chapter once and filters down to the favorited
/// item ids within it.
@injectable
class GetAzkarFavorites {
  final AzkarRepository repository;

  const GetAzkarFavorites(this.repository);

  Future<List<AzkarItemEntity>> call(Database db,
      {required Language language}) async {
    final refs = await repository.getFavoriteRefs(db, language: language);

    final favoriteItemIds = refs.map((ref) => ref.azkarItemId).toSet();
    final chapterIds = refs.map((ref) => ref.chapterId).toSet();

    final items = <AzkarItemEntity>[];
    for (final chapterId in chapterIds) {
      final chapterItems = await repository.getItems(
        language: language,
        chapterId: chapterId,
      );
      items.addAll(
        chapterItems.where((item) => favoriteItemIds.contains(item.id)),
      );
    }

    return items;
  }
}
