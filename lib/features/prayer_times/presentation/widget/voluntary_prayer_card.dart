import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../src/core/util/bloc/time_format/time_format_bloc.dart';
import '../../../../src/core/util/constants.dart';
import '../../../../src/core/util/controller/timing_controller.dart';

class VoluntaryPrayerCard extends StatelessWidget {
  const VoluntaryPrayerCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.startTime,
    this.endTime,
  });

  final String title;
  final String subtitle;
  final DateTime startTime;

  /// Null when there's no known end (e.g. Ishraq is a single recommended
  /// moment, not a window).
  final DateTime? endTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: kCardPadding,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 8.h),
          BlocBuilder<TimeFormatBloc, TimeFormatState>(
            builder: (context, state) {
              String format(DateTime time) => state.is24
                  ? DateFormat('HH:mm').format(time)
                  : convertTimeTo12HourFormat(time);

              final label = endTime == null
                  ? format(startTime)
                  : '${format(startTime)} - ${format(endTime!)}';

              return Text(
                label,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
              );
            },
          ),
        ],
      ),
    );
  }
}
