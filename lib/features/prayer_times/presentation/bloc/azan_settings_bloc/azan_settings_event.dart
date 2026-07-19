part of 'azan_settings_bloc.dart';

abstract class AzanSettingsEvent extends Equatable {
  const AzanSettingsEvent();
}

class ToggleAzan extends AzanSettingsEvent {
  final String prayer;

  const ToggleAzan(this.prayer);

  @override
  List<Object> get props => [prayer];
}
