part of 'daily_reminder_bloc.dart';

class DailyReminderState extends Equatable {
  final bool enabled;
  final int hour;
  final int minute;

  const DailyReminderState({
    required this.enabled,
    this.hour = 8,
    this.minute = 0,
  });

  DailyReminderState copyWith({
    bool? enabled,
    int? hour,
    int? minute,
  }) {
    return DailyReminderState(
      enabled: enabled ?? this.enabled,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
    );
  }

  @override
  List<Object> get props => [enabled, hour, minute];
}
