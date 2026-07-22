import 'package:sqflite/sqflite.dart';

import '../entities/dua_entity.dart';

/// Provides read/write access to the Quranic-verse-based Dua collection.
abstract class DuaRepository {
  Future<Duas> getDuas(Database db);
  Future<Duas> toggleDuaFavorite(Database db, Dua dua);
}
