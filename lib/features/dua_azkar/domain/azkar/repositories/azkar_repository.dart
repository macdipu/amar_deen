import 'package:muslim_data_flutter/muslim_data_flutter.dart' show Language;
import 'package:sqflite/sqflite.dart';

import '../entities/azkar_category_entity.dart';
import '../entities/azkar_chapter_entity.dart';
import '../entities/azkar_favorite_ref_entity.dart';
import '../entities/azkar_item_entity.dart';

/// Provides the Hisnul-Muslim Azkar dataset (via `muslim_data_flutter`) and
/// this app's own favorited-Azkar bookkeeping.
abstract class AzkarRepository {
  Future<List<AzkarCategoryEntity>> getCategories({required Language language});

  Future<List<AzkarChapterEntity>> getChapters({
    required Language language,
    required int categoryId,
  });

  Future<List<AzkarItemEntity>> getItems({
    required Language language,
    required int chapterId,
  });

  Future<List<int>> getFavoriteItemIds(Database db,
      {required Language language});

  Future<List<int>> toggleFavorite(
    Database db, {
    required int azkarItemId,
    required int chapterId,
    required Language language,
  });

  Future<List<AzkarFavoriteRefEntity>> getFavoriteRefs(
    Database db, {
    required Language language,
  });
}
