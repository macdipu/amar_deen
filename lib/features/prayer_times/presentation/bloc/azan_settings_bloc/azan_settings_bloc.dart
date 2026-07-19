import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'azan_settings_event.dart';
part 'azan_settings_state.dart';

const kAzanPrayerNames = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];

class AzanSettingsBloc extends HydratedBloc<AzanSettingsEvent, AzanSettingsState> {
  AzanSettingsBloc()
      : super(
          AzanSettingsState({
            for (final name in kAzanPrayerNames) name: true,
          }),
        ) {
    on<ToggleAzan>((event, emit) {
      emit(
        state.copyWith(
          enabledByPrayer: {
            ...state.enabledByPrayer,
            event.prayer: !state.isEnabled(event.prayer),
          },
        ),
      );
    });
  }

  @override
  AzanSettingsState? fromJson(Map<String, dynamic> json) {
    try {
      final raw = json['enabledByPrayer'] as Map;
      return AzanSettingsState({
        for (final name in kAzanPrayerNames) name: raw[name] as bool? ?? true,
      });
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AzanSettingsState state) {
    try {
      return {'enabledByPrayer': state.enabledByPrayer};
    } catch (_) {
      return null;
    }
  }
}
