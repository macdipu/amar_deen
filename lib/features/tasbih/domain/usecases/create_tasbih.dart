import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

import '../entities/tasbih_entity.dart';
import '../repositories/tasbih_repository.dart';

/// Creates a new Tasbih.
@injectable
class CreateTasbih {
  final TasbihRepository repository;

  const CreateTasbih(this.repository);

  Future<Tasbihs> call(Database db, Map<String, Object> details) =>
      repository.createTasbih(db, details);
}
