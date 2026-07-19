part of 'azan_settings_bloc.dart';

class AzanSettingsState extends Equatable {
  final Map<String, bool> enabledByPrayer;

  const AzanSettingsState(this.enabledByPrayer);

  bool isEnabled(String prayer) => enabledByPrayer[prayer] ?? true;

  AzanSettingsState copyWith({Map<String, bool>? enabledByPrayer}) {
    return AzanSettingsState(enabledByPrayer ?? this.enabledByPrayer);
  }

  @override
  List<Object> get props => [enabledByPrayer];
}
