import '../entities/name_of_allah_entity.dart';

/// Provides the 99 Names of Allah.
abstract class AllahNameRepository {
  Future<List<NameOfAllahEntity>> getNames();
}
