import 'package:injectable/injectable.dart';

import '../entities/name_of_allah_entity.dart';
import '../repositories/allah_name_repository.dart';

/// Fetches the 99 Names of Allah.
@injectable
class GetAllahNames {
  final AllahNameRepository repository;

  const GetAllahNames(this.repository);

  Future<List<NameOfAllahEntity>> call() => repository.getNames();
}
