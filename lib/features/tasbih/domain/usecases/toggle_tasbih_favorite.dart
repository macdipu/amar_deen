import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

import '../entities/tasbih_entity.dart';
import '../repositories/tasbih_repository.dart';

/// Toggles the favorite flag of a Tasbih.
@injectable
class ToggleTasbihFavorite {
  final TasbihRepository repository;

  const ToggleTasbihFavorite(this.repository);

  Future<Tasbihs> call(Database db, Tasbih tasbih) =>
      repository.toggleTasbihFavorite(db, tasbih);
}
