import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

import '../entities/tasbih_entity.dart';
import '../repositories/tasbih_repository.dart';

/// Deletes a Tasbih.
@injectable
class DeleteTasbih {
  final TasbihRepository repository;

  const DeleteTasbih(this.repository);

  Future<Tasbihs> call(Database db, Tasbih tasbih) =>
      repository.deleteTasbih(db, tasbih);
}
