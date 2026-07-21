import 'package:injectable/injectable.dart';

import '../entities/voluntary_fasting_day.dart';
import '../repositories/voluntary_fasting_repository.dart';

/// Returns the next occurrence of each voluntary fasting day type
/// (Monday, Thursday, Ayyam al-Beed, Arafah), sorted by date ascending.
@injectable
class GetUpcomingVoluntaryFastingDays {
  final VoluntaryFastingRepository repository;

  const GetUpcomingVoluntaryFastingDays(this.repository);

  List<VoluntaryFastingDay> call({DateTime? now}) {
    return repository.getUpcomingFastingDays(now: now ?? DateTime.now());
  }
}
