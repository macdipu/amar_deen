import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

import '../entities/dua_entity.dart';
import '../repositories/dua_repository.dart';

/// Toggles a Dua's favorite flag and returns the refreshed Dua collection.
@injectable
class ToggleDuaFavorite {
  final DuaRepository repository;

  const ToggleDuaFavorite(this.repository);

  Future<Duas> call(Database db, Dua dua) =>
      repository.toggleDuaFavorite(db, dua);
}
