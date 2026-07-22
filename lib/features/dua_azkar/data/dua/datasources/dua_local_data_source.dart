import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

import 'package:amar_deen/core/database/database_service.dart';
import '../../../domain/dua/entities/dua_entity.dart';

/// Wraps the app's own SQLite `dua` table access via [DatabaseService].
abstract class DuaLocalDataSource {
  Future<List<Map<String, Object?>>> getDuas(Database db);
  Future<List<Map<String, Object?>>> toggleDuaFavorite(Database db, Dua dua);
}

@LazySingleton(as: DuaLocalDataSource)
class DuaLocalDataSourceImpl implements DuaLocalDataSource {
  const DuaLocalDataSourceImpl();

  @override
  Future<List<Map<String, Object?>>> getDuas(Database db) => db.query('dua');

  @override
  Future<List<Map<String, Object?>>> toggleDuaFavorite(Database db, Dua dua) =>
      DatabaseService().toggleDuaFavorite(db, dua);
}
