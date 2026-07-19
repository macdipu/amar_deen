import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hijri_calendar/hijri_calendar.dart';
import 'package:intl/intl.dart';

import '../../../../features/prayer_times/domain/entities/prayer_times_entity.dart';
import '../../../core/util/bloc/prayer_time_config/prayer_time_config_bloc.dart';
import '../../../core/util/bloc/time_format/time_format_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/controller/timing_controller.dart';

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
  late final int timingCount;
  late final List<MapEntry<String, DateTime>> timingsList;

  SuccessWidgetController(this.prayerTimes, this.context) {
    final controller = TimingController(prayerTimes);
    timingCount = controller.timingCount;
    timingsList = controller.timingsList;
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

  /// Today's Hijri date, computed on-device via `hijri_calendar` (no
  /// network) and shifted by the user's configured [hijriAdjustmentDays].
  String generateIslamicDate() {
    final hijriAdjustmentDays =
        BlocProvider.of<PrayerTimeConfigBloc>(context).state.hijriAdjustmentDays;
    final date = DateTime.now().add(Duration(days: hijriAdjustmentDays));
    final hijri = HijriCalendarConfig.fromGregorian(date);
    return '${hijri.hDay} ${hijri.getLongMonthName()} ${hijri.hYear}';
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
                timingsList[index].key,
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
