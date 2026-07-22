import 'package:injectable/injectable.dart';
import 'package:muslim_data_flutter/muslim_data_flutter.dart' show Language;

import '../entities/azkar_item_entity.dart';
import '../repositories/azkar_repository.dart';

@injectable
class GetAzkarItems {
  final AzkarRepository repository;

  const GetAzkarItems(this.repository);

  Future<List<AzkarItemEntity>> call({
    required Language language,
    required int chapterId,
  }) =>
      repository.getItems(language: language, chapterId: chapterId);
}
