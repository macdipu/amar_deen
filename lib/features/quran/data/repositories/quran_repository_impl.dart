import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

import 'package:amar_deen/core/database/database_service.dart';
import '../../domain/entities/quran.dart';
import '../../domain/repositories/quran_repository.dart';

@LazySingleton(as: QuranRepository)
class QuranRepositoryImpl implements QuranRepository {
  const QuranRepositoryImpl();

  @override
  Future<List<int>> toggleFavorite(Database db, Quran quran) {
    return DatabaseService().toggleQuranFavorite(db, quran);
  }
}
