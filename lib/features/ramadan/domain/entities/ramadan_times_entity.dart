import 'package:equatable/equatable.dart';

/// Suhoor/Iftar times for a Ramadan day, computed entirely on-device from
/// the day's Fajr/Maghrib obligatory prayer times - no separate
/// calculation-engine value exists for these the way there is for the
/// five obligatory prayers themselves. See `RamadanRepositoryImpl` for the
/// exact offset used for [imsak].
class RamadanTimesEntity extends Equatable {
  /// Imsak - the Suhoor (pre-dawn meal) cut-off, shortly before Fajr.
  final DateTime imsak;

  /// Iftar - breaking the fast, exactly at Maghrib.
  final DateTime iftar;

  const RamadanTimesEntity({
    required this.imsak,
    required this.iftar,
  });

  @override
  List<Object> get props => [imsak, iftar];
}
