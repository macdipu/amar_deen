import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/prayer_calculation_method.dart';
import '../bloc/azan_settings_bloc/azan_settings_bloc.dart';
import 'package:amar_deen/core/bloc/location/location_bloc.dart';
import 'package:amar_deen/core/bloc/notification/notification_bloc.dart';
import '../bloc/prayer_time_config_bloc/prayer_time_config_bloc.dart';
import '../bloc/timing_bloc/timing_bloc.dart';
import 'package:amar_deen/core/constants/constants.dart';
import 'package:amar_deen/core/utils/notification_controller.dart';
import 'package:amar_deen/core/utils/prayer_name.dart';
import 'package:amar_deen/core/widgets/bottom_sheet_select.dart';
import 'package:amar_deen/l10n/generated/app_localizations.dart';

class PrayerTimeSettingsScreen extends StatelessWidget {
  const PrayerTimeSettingsScreen({super.key});

  void _refreshTimings(BuildContext context) {
    final locationState = BlocProvider.of<LocationBloc>(context).state;
    final notificationStatus =
        BlocProvider.of<NotificationBloc>(context).state.status;
    final config = BlocProvider.of<PrayerTimeConfigBloc>(context).state;

    BlocProvider.of<TimingBloc>(context).add(
      RequestTiming(
        notificationStatus,
        locationState,
        config.method,
        config.madhab,
        config.dayOffset,
        config.hijriAdjustmentDays,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.prayerSettingsTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: kPagePadding,
            child: BlocBuilder<PrayerTimeConfigBloc, PrayerTimeConfigState>(
              builder: (context, state) {
                return Column(
                  children: [
                    SizedBox(height: 16.h),
                    BottomSheetSelect<PrayerCalculationMethod>(
                      label: l10n.prayerSettingsCalculationMethod,
                      value: state.method,
                      options: PrayerCalculationMethod.values,
                      optionLabelBuilder: (m) => m.label,
                      onChanged: (method) {
                        BlocProvider.of<PrayerTimeConfigBloc>(context)
                            .add(SetPrayerTimeMethod(method));
                        _refreshTimings(context);
                      },
                    ),
                    const Divider(),
                    BottomSheetSelect<PrayerMadhab>(
                      label: l10n.prayerSettingsAsrSchool,
                      value: state.madhab,
                      options: PrayerMadhab.values,
                      optionLabelBuilder: (s) => s.label,
                      onChanged: (madhab) {
                        BlocProvider.of<PrayerTimeConfigBloc>(context)
                            .add(SetPrayerTimeMadhab(madhab));
                        _refreshTimings(context);
                      },
                    ),
                    const Divider(),
                    _StepSettingRow(
                      label: l10n.prayerSettingsDayOffset,
                      value: state.dayOffset,
                      min: 0,
                      max: 2,
                      onChanged: (value) {
                        BlocProvider.of<PrayerTimeConfigBloc>(context)
                            .add(SetPrayerDayOffset(value));
                        _refreshTimings(context);
                      },
                    ),
                    const Divider(),
                    _StepSettingRow(
                      label: l10n.prayerSettingsHijriAdjustment,
                      value: state.hijriAdjustmentDays,
                      min: 0,
                      max: 2,
                      onChanged: (value) {
                        BlocProvider.of<PrayerTimeConfigBloc>(context)
                            .add(SetHijriAdjustmentDays(value));
                        _refreshTimings(context);
                      },
                    ),
                    const Divider(),
                    SizedBox(height: 8.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          BlocProvider.of<PrayerTimeConfigBloc>(context)
                              .add(const ResetPrayerTimeConfig());
                          _refreshTimings(context);
                        },
                        child: Text(l10n.prayerSettingsResetToDefaults),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        l10n.prayerSettingsAzanReminders,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    BlocBuilder<AzanSettingsBloc, AzanSettingsState>(
                      builder: (context, azanState) {
                        return Column(
                          children: [
                            for (final prayer in kAzanPrayerNames)
                              _AzanToggleRow(
                                prayer: prayer,
                                enabled: azanState.isEnabled(prayer),
                                onChanged: (_) {
                                  BlocProvider.of<AzanSettingsBloc>(context)
                                      .add(ToggleAzan(prayer));
                                  rescheduleAzans(context);
                                },
                              ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _AzanToggleRow extends StatelessWidget {
  const _AzanToggleRow({
    required this.prayer,
    required this.enabled,
    required this.onChanged,
  });

  final String prayer;
  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          localizedPrayerName(context, prayer),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Switch(
          value: enabled,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _StepSettingRow extends StatelessWidget {
  const _StepSettingRow({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String label;
  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final canDecrement = value > min;
    final canIncrement = value < max;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.titleLarge!.copyWith(
                color: theme.primaryColor,
              ),
            ),
          ),
          IconButton(
            onPressed: canDecrement ? () => onChanged(value - 1) : null,
            icon: Icon(Icons.remove, color: theme.primaryColor),
          ),
          Text(
            value.toString(),
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: canIncrement ? () => onChanged(value + 1) : null,
            icon: Icon(Icons.add, color: theme.primaryColor),
          ),
        ],
      ),
    );
  }
}
