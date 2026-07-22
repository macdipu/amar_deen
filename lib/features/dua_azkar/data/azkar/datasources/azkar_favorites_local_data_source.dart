import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

import 'package:amar_deen/core/database/database_service.dart';

/// Wraps this app's own `azkar_favourites` side table access (via
/// [DatabaseService]) — Azkar content itself comes from the bundled
/// `muslim_data_flutter` package's own database, not `assets/latest.db`.
abstract class AzkarFavoritesLocalDataSource {
  Future<List<int>> getFavoriteItemIds(Database db, {required String language});

  Future<List<int>> toggleFavorite(
    Database db, {
    required int azkarItemId,
    required int chapterId,
    required String language,
  });

  Future<List<Map<String, Object?>>> getFavoriteRefs(
    Database db, {
    required String language,
  });
}

@LazySingleton(as: AzkarFavoritesLocalDataSource)
class AzkarFavoritesLocalDataSourceImpl
    implements AzkarFavoritesLocalDataSource {
  const AzkarFavoritesLocalDataSourceImpl();

  @override
  Future<List<int>> getFavoriteItemIds(Database db,
      {required String language}) {
    return DatabaseService().getAzkarFavoriteItemIds(db, language: language);
  }

  @override
  Future<List<int>> toggleFavorite(
    Database db, {
    required int azkarItemId,
    required int chapterId,
    required String language,
  }) {
    return DatabaseService().toggleAzkarFavorite(
      db,
      azkarItemId: azkarItemId,
      chapterId: chapterId,
      language: language,
    );
  }

  @override
  Future<List<Map<String, Object?>>> getFavoriteRefs(
    Database db, {
    required String language,
  }) {
    return DatabaseService().getAzkarFavoriteRefs(db, language: language);
  }
}
