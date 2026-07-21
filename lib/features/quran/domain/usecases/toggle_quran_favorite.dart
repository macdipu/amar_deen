import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

import '../entities/quran.dart';
import '../repositories/quran_repository.dart';

@injectable
class ToggleQuranFavorite {
  final QuranRepository repository;

  const ToggleQuranFavorite(this.repository);

  Future<List<int>> call(Database db, Quran quran) {
    return repository.toggleFavorite(db, quran);
  }
}
