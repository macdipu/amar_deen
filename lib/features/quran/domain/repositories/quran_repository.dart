import 'package:sqflite/sqflite.dart';

import '../entities/quran.dart';

/// Wraps the bundled SQLite `quran_favourites` table (see
/// `DatabaseService`). This app's DB connection is threaded through call
/// sites as a raw `Database` handle everywhere else already (see
/// `DatabaseBloc`, `toggleDuaFavorite`, `toggleTasbihFavorite`), so this
/// repository follows the same convention rather than introducing a new
/// abstraction the rest of the app doesn't use.
abstract class QuranRepository {
  /// Toggles [quran]'s favorite state and returns the full, updated list
  /// of favorited Ayah ids.
  Future<List<int>> toggleFavorite(Database db, Quran quran);
}
