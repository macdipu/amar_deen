import '../entities/voluntary_fasting_day.dart';

/// Computes upcoming voluntary (non-obligatory) fasting days entirely
/// on-device via the Hijri calendar - no network access.
abstract class VoluntaryFastingRepository {
  /// Returns the next occurrence of each [VoluntaryFastingType], sorted by
  /// date ascending. A type is omitted only if no occurrence could be
  /// found within the search window (should not happen in practice).
  List<VoluntaryFastingDay> getUpcomingFastingDays({required DateTime now});
}
