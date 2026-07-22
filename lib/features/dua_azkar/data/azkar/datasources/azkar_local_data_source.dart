import 'package:injectable/injectable.dart';
import 'package:muslim_data_flutter/muslim_data_flutter.dart';

/// Wraps the `muslim_data_flutter` package's Azkar (Hisnul-Muslim) dataset.
abstract class AzkarLocalDataSource {
  Future<List<AzkarCategory>> getCategories({required Language language});

  Future<List<AzkarChapter>> getChapters({
    required Language language,
    required int categoryId,
  });

  Future<List<AzkarItem>> getItems({
    required Language language,
    required int chapterId,
  });
}

@LazySingleton(as: AzkarLocalDataSource)
class AzkarLocalDataSourceImpl implements AzkarLocalDataSource {
  AzkarLocalDataSourceImpl() : _repo = MuslimRepository();

  final MuslimRepository _repo;

  @override
  Future<List<AzkarCategory>> getCategories({required Language language}) {
    return _repo.getAzkarCategories(language: language);
  }

  @override
  Future<List<AzkarChapter>> getChapters({
    required Language language,
    required int categoryId,
  }) {
    return _repo.getAzkarChapters(language: language, categoryId: categoryId);
  }

  @override
  Future<List<AzkarItem>> getItems({
    required Language language,
    required int chapterId,
  }) {
    return _repo.getAzkarItems(language: language, chapterId: chapterId);
  }
}
