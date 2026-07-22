import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/entities/tasbih_entity.dart';
import '../../domain/repositories/tasbih_repository.dart';
import '../datasources/tasbih_local_data_source.dart';

@LazySingleton(as: TasbihRepository)
class TasbihRepositoryImpl implements TasbihRepository {
  final TasbihLocalDataSource localDataSource;

  const TasbihRepositoryImpl(this.localDataSource);

  @override
  Future<Tasbihs> getTasbihs(Database db) async {
    final rows = await localDataSource.getTasbihs(db);
    return Tasbihs()..initializeData(rows);
  }

  @override
  Future<Tasbihs> toggleTasbihFavorite(Database db, Tasbih tasbih) async {
    final rows = await localDataSource.toggleTasbihFavorite(db, tasbih);
    return Tasbihs()..initializeData(rows);
  }

  @override
  Future<Tasbihs> createTasbih(Database db, Map<String, Object> details) async {
    final rows = await localDataSource.createTasbih(db, details);
    return Tasbihs()..initializeData(rows);
  }

  @override
  Future<Tasbihs> editTasbih(
      Database db, Tasbih tasbih, Map<String, Object> details) async {
    final rows = await localDataSource.editTasbih(db, tasbih, details);
    return Tasbihs()..initializeData(rows);
  }

  @override
  Future<Tasbihs> deleteTasbih(Database db, Tasbih tasbih) async {
    final rows = await localDataSource.deleteTasbih(db, tasbih);
    return Tasbihs()..initializeData(rows);
  }
}
