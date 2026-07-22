import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/dua/entities/dua_entity.dart';
import '../../../domain/dua/repositories/dua_repository.dart';
import '../datasources/dua_local_data_source.dart';

@LazySingleton(as: DuaRepository)
class DuaRepositoryImpl implements DuaRepository {
  final DuaLocalDataSource localDataSource;

  const DuaRepositoryImpl(this.localDataSource);

  @override
  Future<Duas> getDuas(Database db) async {
    final rows = await localDataSource.getDuas(db);
    return Duas()..initializeData(rows);
  }

  @override
  Future<Duas> toggleDuaFavorite(Database db, Dua dua) async {
    final rows = await localDataSource.toggleDuaFavorite(db, dua);
    return Duas()..initializeData(rows);
  }
}
