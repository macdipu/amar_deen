import 'package:injectable/injectable.dart';
import 'package:muslim_data_flutter/muslim_data_flutter.dart';

/// Wraps the `muslim_data_flutter` package's names-of-Allah lookup.
abstract class AllahNameLocalDataSource {
  Future<List<NameOfAllah>> getNames();
}

@LazySingleton(as: AllahNameLocalDataSource)
class AllahNameLocalDataSourceImpl implements AllahNameLocalDataSource {
  const AllahNameLocalDataSourceImpl();

  @override
  Future<List<NameOfAllah>> getNames() {
    final muslimRepo = MuslimRepository();
    return muslimRepo.getNames(language: Language.en);
  }
}
