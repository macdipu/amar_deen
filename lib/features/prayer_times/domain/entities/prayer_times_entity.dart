import 'package:equatable/equatable.dart';

/// A single day's five daily prayer times plus sunrise, computed entirely
/// on-device (no network).
class PrayerTimesEntity extends Equatable {
  final DateTime fajr;
  final DateTime sunrise;
  final DateTime dhuhr;
  final DateTime asr;
  final DateTime maghrib;
  final DateTime isha;

  const PrayerTimesEntity({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  @override
  List<Object> get props => [fajr, sunrise, dhuhr, asr, maghrib, isha];
}
