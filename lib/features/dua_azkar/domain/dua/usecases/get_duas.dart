import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

import '../entities/dua_entity.dart';
import '../repositories/dua_repository.dart';

/// Fetches every Dua from the bundled database, categorized by surah.
@injectable
class GetDuas {
  final DuaRepository repository;

  const GetDuas(this.repository);

  Future<Duas> call(Database db) => repository.getDuas(db);
}
