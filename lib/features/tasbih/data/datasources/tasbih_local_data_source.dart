import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

import 'package:amar_deen/core/database/database_service.dart';
import '../../domain/entities/tasbih_entity.dart';

/// Wraps the app's own SQLite `tasbih` table access via [DatabaseService].
abstract class TasbihLocalDataSource {
  Future<List<Map<String, Object?>>> getTasbihs(Database db);
  Future<List<Map<String, Object?>>> toggleTasbihFavorite(
      Database db, Tasbih tasbih);
  Future<List<Map<String, Object?>>> createTasbih(
      Database db, Map<String, Object> details);
  Future<List<Map<String, Object?>>> editTasbih(
      Database db, Tasbih tasbih, Map<String, Object> details);
  Future<List<Map<String, Object?>>> deleteTasbih(Database db, Tasbih tasbih);
}

@LazySingleton(as: TasbihLocalDataSource)
class TasbihLocalDataSourceImpl implements TasbihLocalDataSource {
  const TasbihLocalDataSourceImpl();

  @override
  Future<List<Map<String, Object?>>> getTasbihs(Database db) =>
      db.query('tasbih');

  @override
  Future<List<Map<String, Object?>>> toggleTasbihFavorite(
          Database db, Tasbih tasbih) =>
      DatabaseService().toggleTasbihFavorite(db, tasbih);

  @override
  Future<List<Map<String, Object?>>> createTasbih(
          Database db, Map<String, Object> details) =>
      DatabaseService().createTasbih(db, details);

  @override
  Future<List<Map<String, Object?>>> editTasbih(
          Database db, Tasbih tasbih, Map<String, Object> details) =>
      DatabaseService().editTasbih(db, tasbih, details);

  @override
  Future<List<Map<String, Object?>>> deleteTasbih(Database db, Tasbih tasbih) =>
      DatabaseService().deleteTasbih(db, tasbih);
}
