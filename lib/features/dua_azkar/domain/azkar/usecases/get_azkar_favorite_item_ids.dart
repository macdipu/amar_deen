import 'package:injectable/injectable.dart';
import 'package:muslim_data_flutter/muslim_data_flutter.dart' show Language;
import 'package:sqflite/sqflite.dart';

import '../repositories/azkar_repository.dart';

@injectable
class GetAzkarFavoriteItemIds {
  final AzkarRepository repository;

  const GetAzkarFavoriteItemIds(this.repository);

  Future<List<int>> call(Database db, {required Language language}) =>
      repository.getFavoriteItemIds(db, language: language);
}
