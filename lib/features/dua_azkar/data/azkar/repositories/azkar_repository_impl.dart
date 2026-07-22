import 'package:injectable/injectable.dart';
import 'package:muslim_data_flutter/muslim_data_flutter.dart' show Language;
import 'package:sqflite/sqflite.dart';

import '../../../domain/azkar/entities/azkar_category_entity.dart';
import '../../../domain/azkar/entities/azkar_chapter_entity.dart';
import '../../../domain/azkar/entities/azkar_favorite_ref_entity.dart';
import '../../../domain/azkar/entities/azkar_item_entity.dart';
import '../../../domain/azkar/repositories/azkar_repository.dart';
import '../datasources/azkar_favorites_local_data_source.dart';
import '../datasources/azkar_local_data_source.dart';

@LazySingleton(as: AzkarRepository)
class AzkarRepositoryImpl implements AzkarRepository {
  final AzkarLocalDataSource localDataSource;
  final AzkarFavoritesLocalDataSource favoritesLocalDataSource;

  const AzkarRepositoryImpl(
      this.localDataSource, this.favoritesLocalDataSource);

  @override
  Future<List<AzkarCategoryEntity>> getCategories(
      {required Language language}) async {
    final categories = await localDataSource.getCategories(language: language);
    return categories
        .map((category) =>
            AzkarCategoryEntity(id: category.id, name: category.name))
        .toList();
  }

  @override
  Future<List<AzkarChapterEntity>> getChapters({
    required Language language,
    required int categoryId,
  }) async {
    final chapters = await localDataSource.getChapters(
      language: language,
      categoryId: categoryId,
    );
    return chapters
        .map((chapter) => AzkarChapterEntity(
              id: chapter.id,
              categoryId: chapter.categoryId,
              categoryName: chapter.categoryName,
              name: chapter.name,
            ))
        .toList();
  }

  @override
  Future<List<AzkarItemEntity>> getItems({
    required Language language,
    required int chapterId,
  }) async {
    final items = await localDataSource.getItems(
      language: language,
      chapterId: chapterId,
    );
    return items
        .map((item) => AzkarItemEntity(
              id: item.id,
              chapterId: item.chapterId,
              item: item.item,
              translation: item.translation,
              reference: item.reference,
            ))
        .toList();
  }

  @override
  Future<List<int>> getFavoriteItemIds(Database db,
      {required Language language}) {
    return favoritesLocalDataSource.getFavoriteItemIds(db,
        language: language.value);
  }

  @override
  Future<List<int>> toggleFavorite(
    Database db, {
    required int azkarItemId,
    required int chapterId,
    required Language language,
  }) {
    return favoritesLocalDataSource.toggleFavorite(
      db,
      azkarItemId: azkarItemId,
      chapterId: chapterId,
      language: language.value,
    );
  }

  @override
  Future<List<AzkarFavoriteRefEntity>> getFavoriteRefs(
    Database db, {
    required Language language,
  }) async {
    final refs = await favoritesLocalDataSource.getFavoriteRefs(db,
        language: language.value);
    return refs
        .map((row) => AzkarFavoriteRefEntity(
              azkarItemId: row['azkar_item_id'] as int,
              chapterId: row['chapter_id'] as int,
            ))
        .toList();
  }
}
