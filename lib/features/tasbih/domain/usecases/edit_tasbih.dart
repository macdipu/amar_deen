import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

import '../entities/tasbih_entity.dart';
import '../repositories/tasbih_repository.dart';

/// Edits an existing Tasbih's name and/or target counter.
@injectable
class EditTasbih {
  final TasbihRepository repository;

  const EditTasbih(this.repository);

  Future<Tasbihs> call(
          Database db, Tasbih tasbih, Map<String, Object> details) =>
      repository.editTasbih(db, tasbih, details);
}
