import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sirat_e_mustaqeem/l10n/generated/app_localizations.dart';

import '../../../../core/localization/locale_bloc/locale_bloc.dart';
import '../../../../core/theme/theme_bloc/theme_bloc.dart';
import '../../../core/util/bloc/daily_reminder/daily_reminder_bloc.dart';
import '../../../core/util/bloc/notification/notification_bloc.dart';
import '../../../core/util/bloc/time_format/time_format_bloc.dart';
import '../../../core/util/controller/notification_controller.dart';
import '../../../core/util/controller/timing_controller.dart';
import '../../utils/sirat_card.dart';
import '../controller/setting_controller.dart';
import 'change_format_switch.dart';
import 'change_language_switch.dart';
import 'change_notification_switch.dart';
import 'change_theme_switch.dart';

class UserPreferenceCard extends StatelessWidget {
  const UserPreferenceCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SiratCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.settingUserPreferences,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.settingTheme,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, state) {
                  return ChangeThemeSwitch(
                      value: state.currentTheme.brightness == Brightness.dark,
                      onChanged: (_) {
                        BlocProvider.of<ThemeBloc>(context).add(
                          ToggleTheme(),
                        );
                      });
                },
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.settingTimeFormat,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              BlocBuilder<TimeFormatBloc, TimeFormatState>(
                builder: (context, state) {
                  return ChangeFormatSwitch(
                      value: state.is24,
                      onChanged: (_) {
                        BlocProvider.of<TimeFormatBloc>(context).add(
                          ToggleFormat(),
                        );
                      });
                },
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.settingNotification,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              BlocBuilder<NotificationBloc, NotificationState>(
                builder: (context, state) {
                  return ChangeNotificationSwitch(
                      value: state.status == PermissionStatus.granted,
                      onChanged: (_) {
                        notificationSwitchOnToggle(state, context);
                      });
                },
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.settingLanguage,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              BlocBuilder<LocaleBloc, LocaleState>(
                builder: (context, state) {
                  return ChangeLanguageSwitch(
                      isBangla: state.locale.languageCode == 'bn',
                      onChanged: (toBangla) {
                        BlocProvider.of<LocaleBloc>(context).add(
                          ChangeLocale(
                              Locale(toBangla ? 'bn' : 'en')),
                        );
                      });
                },
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.settingDailyReminder,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              BlocBuilder<DailyReminderBloc, DailyReminderState>(
                builder: (context, state) {
                  return ChangeNotificationSwitch(
                      value: state.enabled,
                      onChanged: (_) {
                        BlocProvider.of<DailyReminderBloc>(context).add(
                          ToggleDailyReminder(),
                        );
                        rescheduleDailyReminder(context);
                      });
                },
              ),
            ],
          ),
          BlocBuilder<DailyReminderBloc, DailyReminderState>(
            builder: (context, state) {
              if (!state.enabled) {
                return SizedBox.shrink();
              }
              return Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: GestureDetector(
                  onTap: () async {
                    final timeFormatState =
                        BlocProvider.of<TimeFormatBloc>(context).state;
                    final picked = await showTimePicker(
                      context: context,
                      initialTime:
                          TimeOfDay(hour: state.hour, minute: state.minute),
                      builder: (context, child) {
                        return MediaQuery(
                          data: MediaQuery.of(context).copyWith(
                            alwaysUse24HourFormat: timeFormatState.is24,
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (picked == null || !context.mounted) return;
                    BlocProvider.of<DailyReminderBloc>(context).add(
                      SetDailyReminderTime(
                          hour: picked.hour, minute: picked.minute),
                    );
                    rescheduleDailyReminder(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.settingDailyReminderTime,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                      BlocBuilder<TimeFormatBloc, TimeFormatState>(
                        builder: (context, timeFormatState) {
                          final time =
                              DateTime(0, 1, 1, state.hour, state.minute);
                          return Text(
                            timeFormatState.is24
                                ? DateFormat('HH:mm').format(time)
                                : convertTimeTo12HourFormat(time),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
