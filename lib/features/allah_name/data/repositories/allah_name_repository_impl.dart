import 'package:injectable/injectable.dart';

import '../../domain/entities/name_of_allah_entity.dart';
import '../../domain/repositories/allah_name_repository.dart';
import '../datasources/allah_name_local_data_source.dart';

@LazySingleton(as: AllahNameRepository)
class AllahNameRepositoryImpl implements AllahNameRepository {
  final AllahNameLocalDataSource localDataSource;

  const AllahNameRepositoryImpl(this.localDataSource);

  @override
  Future<List<NameOfAllahEntity>> getNames() async {
    final names = await localDataSource.getNames();
    return names
        .map((name) => NameOfAllahEntity(
              id: name.id,
              name: name.name,
              translation: name.translation,
              transliteration: name.transliteration,
            ))
        .toList();
  }
}
