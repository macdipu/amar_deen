import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

import '../entities/tasbih_entity.dart';
import '../repositories/tasbih_repository.dart';

/// Fetches every Tasbih from the bundled database.
@injectable
class GetTasbihs {
  final TasbihRepository repository;

  const GetTasbihs(this.repository);

  Future<Tasbihs> call(Database db) => repository.getTasbihs(db);
}
