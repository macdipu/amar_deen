import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../features/prayer_times/domain/entities/prayer_times_entity.dart';
import '../../../core/util/bloc/time_format/time_format_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/controller/date_controller.dart';
import '../controller/success_widget_controller.dart';

class SuccessWidget extends StatelessWidget {
  const SuccessWidget(this.prayerTimes);

  final PrayerTimesEntity prayerTimes;

  @override
  Widget build(BuildContext context) {
    final SuccessWidgetController controller =
        SuccessWidgetController(prayerTimes, context);
    return Stack(
      children: [
        Container(
          width: 1.sw,
          height: 1.sh,
          child: SvgPicture.asset(
            controller.setBackgroundImage(),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: kPagePadding,
                child: Text(
                  getTodayDate(),
                  style: GoogleFonts.caveat(
                    textStyle:
                        Theme.of(context).textTheme.displaySmall!.copyWith(
                              color: Colors.white,
                            ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Padding(
                padding: kPagePadding,
                child: Text(
                  controller.generateIslamicDate(),
                  style: GoogleFonts.caveat(
                    textStyle:
                        Theme.of(context).textTheme.displaySmall!.copyWith(
                              color: Colors.white,
                            ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Padding(
                padding: kPagePadding,
                child: BlocBuilder<TimeFormatBloc, TimeFormatState>(
                  builder: (context, timeFormatState) {
                    return Text(
                      controller.currentPrayerWindowLabel(
                        is24Hour: timeFormatState.is24,
                      ),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                width: 1.sw,
                padding: kCardPadding,
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .surface
                        .withValues(alpha: 0.2),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.r),
                      topRight: Radius.circular(32.r),
                    )),
                child: Column(
                  children: controller.generateTimingList(),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
