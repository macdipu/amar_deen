import 'package:injectable/injectable.dart';
import 'package:muslim_data_flutter/muslim_data_flutter.dart' show Language;
import 'package:sqflite/sqflite.dart';

import '../repositories/azkar_repository.dart';

@injectable
class ToggleAzkarFavorite {
  final AzkarRepository repository;

  const ToggleAzkarFavorite(this.repository);

  Future<List<int>> call(
    Database db, {
    required int azkarItemId,
    required int chapterId,
    required Language language,
  }) =>
      repository.toggleFavorite(
        db,
        azkarItemId: azkarItemId,
        chapterId: chapterId,
        language: language,
      );
}
