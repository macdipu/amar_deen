import 'package:sqflite/sqflite.dart';

import '../entities/tasbih_entity.dart';

/// Provides read/write access to the user's Tasbih (dhikr counter)
/// collection.
abstract class TasbihRepository {
  Future<Tasbihs> getTasbihs(Database db);
  Future<Tasbihs> toggleTasbihFavorite(Database db, Tasbih tasbih);
  Future<Tasbihs> createTasbih(Database db, Map<String, Object> details);
  Future<Tasbihs> editTasbih(
      Database db, Tasbih tasbih, Map<String, Object> details);
  Future<Tasbihs> deleteTasbih(Database db, Tasbih tasbih);
}
