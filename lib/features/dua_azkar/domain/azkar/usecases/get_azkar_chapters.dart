import 'package:injectable/injectable.dart';
import 'package:muslim_data_flutter/muslim_data_flutter.dart' show Language;

import '../entities/azkar_chapter_entity.dart';
import '../repositories/azkar_repository.dart';

@injectable
class GetAzkarChapters {
  final AzkarRepository repository;

  const GetAzkarChapters(this.repository);

  Future<List<AzkarChapterEntity>> call({
    required Language language,
    required int categoryId,
  }) =>
      repository.getChapters(language: language, categoryId: categoryId);
}
