import 'package:equatable/equatable.dart';

/// Recommended (non-obligatory) prayer windows for a day, computed
/// entirely on-device from the day's obligatory prayer times.
///
/// Exact minute offsets for Ishraq/Duha vary by scholarly opinion - there
/// is no single calculation-engine-provided value the way there is for
/// the five obligatory prayers. This uses commonly-cited defaults
/// (see `AdhanLocalDataSource.getVoluntaryTimes`); Tahajjud's window
/// (last third of the night) is computed by `adhan_dart`'s own
/// `SunnahTimes`, so it carries the same precision as the obligatory
/// prayer calculation.
class VoluntaryPrayerTimesEntity extends Equatable {
  /// Ishraq - shortly after sunrise, once the sun has fully risen.
  final DateTime ishraq;

  /// Duha (Chasht) window - from shortly after sunrise until just before
  /// Dhuhr (Zawal).
  final DateTime duhaStart;
  final DateTime duhaEnd;

  /// Tahajjud window - the last third of the night, the most virtuous
  /// time for voluntary night prayer.
  final DateTime tahajjudStart;
  final DateTime tahajjudEnd;

  const VoluntaryPrayerTimesEntity({
    required this.ishraq,
    required this.duhaStart,
    required this.duhaEnd,
    required this.tahajjudStart,
    required this.tahajjudEnd,
  });

  @override
  List<Object> get props => [
        ishraq,
        duhaStart,
        duhaEnd,
        tahajjudStart,
        tahajjudEnd,
      ];
}
