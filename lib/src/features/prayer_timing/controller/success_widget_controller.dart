import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../features/prayer_times/domain/entities/prayer_times_entity.dart';
import '../../../core/util/bloc/prayer_time_config/prayer_time_config_bloc.dart';
import '../../../core/util/bloc/time_format/time_format_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/controller/date_controller.dart';
import '../../../core/util/controller/timing_controller.dart';
import '../../../core/util/prayer_name.dart';
import 'package:sirat_e_mustaqeem/l10n/generated/app_localizations.dart';

enum TimingProps {
  Fajr,
  Dhuhr,
  Asr,
  Maghrib,
  Isha,
}

Map<TimingProps, String> backgroundAsset = {
  TimingProps.Fajr: 'assets/images/praying_time/svg/morning.svg',
  TimingProps.Dhuhr: 'assets/images/praying_time/svg/noon.svg',
  TimingProps.Asr: 'assets/images/praying_time/svg/afternoon.svg',
  TimingProps.Maghrib: 'assets/images/praying_time/svg/evening.svg',
  TimingProps.Isha: 'assets/images/praying_time/svg/night.svg',
};

class SuccessWidgetController {
  final PrayerTimesEntity prayerTimes;
  final BuildContext context;
  late final TimingController _controller;
  late final int timingCount;
  late final List<MapEntry<String, DateTime>> timingsList;

  SuccessWidgetController(this.prayerTimes, this.context) {
    _controller = TimingController(prayerTimes);
    timingCount = _controller.timingCount;
    timingsList = _controller.timingsList;
  }

  String setBackgroundImage() {
    switch (timingCount) {
      case 0:
        return backgroundAsset[TimingProps.Fajr]!;
      case 1:
        return backgroundAsset[TimingProps.Dhuhr]!;
      case 2:
        return backgroundAsset[TimingProps.Asr]!;
      case 3:
        return backgroundAsset[TimingProps.Maghrib]!;
      case 4:
        return backgroundAsset[TimingProps.Isha]!;
      default:
        return backgroundAsset[TimingProps.Fajr]!;
    }
  }

  /// Today's Hijri date, shifted by the user's configured
  /// [hijriAdjustmentDays].
  String generateIslamicDate() {
    final hijriAdjustmentDays = BlocProvider.of<PrayerTimeConfigBloc>(context)
        .state
        .hijriAdjustmentDays;
    return getIslamicDate(adjustmentDays: hijriAdjustmentDays);
  }

  /// "Dhuhr — 12:34 PM to 3:45 PM" for the currently active prayer window,
  /// or "Isha — from 8:12 PM" once Isha's window has no known end (it
  /// continues into tomorrow's Fajr, outside a single day's data).
  String currentPrayerWindowLabel({required bool is24Hour}) {
    String format(DateTime time) => is24Hour
        ? DateFormat('HH:mm').format(time)
        : convertTimeTo12HourFormat(time);

    final name = localizedPrayerName(context, _controller.currentWindowPrayer);
    final start = format(_controller.currentWindowStart);
    final end = _controller.currentWindowEnd;

    if (end == null) {
      return AppLocalizations.of(context).prayerWindowFrom(name, start);
    }
    return AppLocalizations.of(context)
        .prayerWindowRange(name, start, format(end));
  }

  List<Widget> generateTimingList() {
    return List.generate(
      timingsList.length,
      (index) => Container(
        decoration: index == timingCount
            ? BoxDecoration(
                color: kDarkPlaceholder.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(
                  8.r,
                ),
              )
            : null,
        padding: EdgeInsets.symmetric(
          horizontal: 8.w,
          vertical: 12.h,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                localizedPrayerName(context, timingsList[index].key),
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
            Expanded(
              child: BlocBuilder<TimeFormatBloc, TimeFormatState>(
                builder: (context, state) {
                  return Text(
                    state.is24
                        ? DateFormat('HH:mm').format(timingsList[index].value)
                        : convertTimeTo12HourFormat(timingsList[index].value),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                        ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
