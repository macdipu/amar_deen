part of 'daily_reminder_bloc.dart';

abstract class DailyReminderEvent extends Equatable {
  const DailyReminderEvent();

  @override
  List<Object> get props => [];
}

class ToggleDailyReminder extends DailyReminderEvent {}

class SetDailyReminderTime extends DailyReminderEvent {
  final int hour;
  final int minute;

  const SetDailyReminderTime({required this.hour, required this.minute});

  @override
  List<Object> get props => [hour, minute];
}
