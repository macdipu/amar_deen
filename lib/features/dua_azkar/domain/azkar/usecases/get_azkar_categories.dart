import 'package:injectable/injectable.dart';
import 'package:muslim_data_flutter/muslim_data_flutter.dart' show Language;

import '../entities/azkar_category_entity.dart';
import '../repositories/azkar_repository.dart';

@injectable
class GetAzkarCategories {
  final AzkarRepository repository;

  const GetAzkarCategories(this.repository);

  Future<List<AzkarCategoryEntity>> call({required Language language}) =>
      repository.getCategories(language: language);
}
