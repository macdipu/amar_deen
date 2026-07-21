import 'package:equatable/equatable.dart';

enum VoluntaryFastingType { monday, thursday, ayyamAlBeed, arafah }

/// A single upcoming recommended (non-obligatory) fasting day, computed
/// entirely on-device via the Hijri calendar - no network access. See
/// `VoluntaryFastingRepositoryImpl` for how each [VoluntaryFastingType] is
/// found.
class VoluntaryFastingDay extends Equatable {
  final VoluntaryFastingType type;

  /// The Gregorian date of the fasting day itself.
  final DateTime date;

  /// The moment a reminder notification should fire - the evening before
  /// [date], so there's time to plan Suhoor and make the intention
  /// (niyyah) the night before.
  final DateTime reminderAt;

  const VoluntaryFastingDay({
    required this.type,
    required this.date,
    required this.reminderAt,
  });

  @override
  List<Object> get props => [type, date, reminderAt];
}
