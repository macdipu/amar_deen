import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../../../features/prayer_times/domain/entities/prayer_calculation_method.dart';

part 'prayer_time_config_event.dart';
part 'prayer_time_config_state.dart';

class PrayerTimeConfigBloc
    extends HydratedBloc<PrayerTimeConfigEvent, PrayerTimeConfigState> {
  PrayerTimeConfigBloc()
      : super(
          const PrayerTimeConfigState(
            method: PrayerCalculationMethod.muslimWorldLeague,
            madhab: PrayerMadhab.shafi,
            dayOffset: 0,
            hijriAdjustmentDays: 0,
          ),
        ) {
    on<PrayerTimeConfigEvent>((event, emit) async {
      if (event is SetPrayerTimeMethod) {
        emit(state.copyWith(method: event.method));
      } else if (event is SetPrayerTimeMadhab) {
        emit(state.copyWith(madhab: event.madhab));
      } else if (event is SetPrayerDayOffset) {
        emit(state.copyWith(dayOffset: event.offset.clamp(0, 2)));
      } else if (event is SetHijriAdjustmentDays) {
        emit(state.copyWith(hijriAdjustmentDays: event.offset.clamp(0, 2)));
      } else if (event is ResetPrayerTimeConfig) {
        emit(const PrayerTimeConfigState(
          method: PrayerCalculationMethod.muslimWorldLeague,
          madhab: PrayerMadhab.shafi,
          dayOffset: 0,
          hijriAdjustmentDays: 0,
        ));
      }
    });
  }

  @override
  PrayerTimeConfigState? fromJson(Map<String, dynamic> json) {
    try {
      final method = PrayerCalculationMethod.values.byNameOrNull(
            json['method']?.toString(),
          ) ??
          PrayerCalculationMethod.muslimWorldLeague;
      final madhab =
          PrayerMadhab.values.byNameOrNull(json['madhab']?.toString()) ??
              PrayerMadhab.shafi;
      final dayOffset = int.tryParse(json['dayOffset']?.toString() ?? '') ?? 0;
      final hijriAdj =
          int.tryParse(json['hijriAdjustmentDays']?.toString() ?? '') ?? 0;

      return PrayerTimeConfigState(
        method: method,
        madhab: madhab,
        dayOffset: dayOffset.clamp(0, 2),
        hijriAdjustmentDays: hijriAdj.clamp(0, 2),
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(PrayerTimeConfigState state) {
    try {
      return {
        'method': state.method.name,
        'madhab': state.madhab.name,
        'dayOffset': state.dayOffset,
        'hijriAdjustmentDays': state.hijriAdjustmentDays,
      };
    } catch (_) {
      return null;
    }
  }
}

extension PrayerCalculationMethodLabel on PrayerCalculationMethod {
  String get label {
    switch (this) {
      case PrayerCalculationMethod.muslimWorldLeague:
        return 'Muslim World League';
      case PrayerCalculationMethod.northAmerica:
        return 'ISNA (North America)';
      case PrayerCalculationMethod.egyptian:
        return 'Egyptian';
      case PrayerCalculationMethod.ummAlQura:
        return 'Umm al-Qura (Makkah)';
      case PrayerCalculationMethod.karachi:
        return 'Karachi';
      case PrayerCalculationMethod.tehran:
        return 'Tehran';
      case PrayerCalculationMethod.jafari:
        return 'Jafari';
    }
  }
}

extension PrayerMadhabLabel on PrayerMadhab {
  String get label {
    switch (this) {
      case PrayerMadhab.shafi:
        return 'Shafi';
      case PrayerMadhab.hanafi:
        return 'Hanafi';
    }
  }
}

extension _EnumByNameOrNull<T extends Enum> on Iterable<T> {
  T? byNameOrNull(String? name) {
    if (name == null) return null;
    for (final value in this) {
      if (value.name == name) return value;
    }
    return null;
  }
}
