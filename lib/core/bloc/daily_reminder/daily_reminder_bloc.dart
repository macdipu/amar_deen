import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'daily_reminder_event.dart';
part 'daily_reminder_state.dart';

class DailyReminderBloc
    extends HydratedBloc<DailyReminderEvent, DailyReminderState> {
  DailyReminderBloc() : super(const DailyReminderState(enabled: false)) {
    on<DailyReminderEvent>((event, emit) async {
      if (event is ToggleDailyReminder) {
        emit(state.copyWith(enabled: !state.enabled));
      } else if (event is SetDailyReminderTime) {
        emit(state.copyWith(hour: event.hour, minute: event.minute));
      }
    });
  }

  @override
  DailyReminderState? fromJson(Map<String, dynamic> json) {
    try {
      return DailyReminderState(
        enabled: json['enabled'] as bool,
        hour: json['hour'] as int,
        minute: json['minute'] as int,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(DailyReminderState state) {
    try {
      return {
        'enabled': state.enabled,
        'hour': state.hour,
        'minute': state.minute,
      };
    } catch (e) {
      return null;
    }
  }
}
