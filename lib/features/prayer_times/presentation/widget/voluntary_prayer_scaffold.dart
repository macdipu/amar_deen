import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../src/core/util/bloc/location/location_bloc.dart';
import '../../../../src/core/util/bloc/prayer_time_config/prayer_time_config_bloc.dart';
import '../../../../src/core/util/constants.dart';
import '../../../../src/features/error/widget/failure_widget.dart';
import '../../../../src/features/utils/loading_widget.dart';
import '../bloc/voluntary_prayer_bloc/voluntary_prayer_bloc.dart';
import 'voluntary_prayer_card.dart';

class VoluntaryPrayerScaffold extends StatefulWidget {
  const VoluntaryPrayerScaffold();

  @override
  State<VoluntaryPrayerScaffold> createState() =>
      _VoluntaryPrayerScaffoldState();
}

class _VoluntaryPrayerScaffoldState extends State<VoluntaryPrayerScaffold> {
  @override
  void didChangeDependencies() {
    final prayerConfig = BlocProvider.of<PrayerTimeConfigBloc>(context).state;
    BlocProvider.of<VoluntaryPrayerBloc>(context).add(
      RequestVoluntaryPrayerTimes(
        BlocProvider.of<LocationBloc>(context).state,
        prayerConfig.method,
        prayerConfig.madhab,
        prayerConfig.dayOffset,
      ),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voluntary Prayers'),
      ),
      body: BlocBuilder<VoluntaryPrayerBloc, VoluntaryPrayerState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: kAnimationDuration,
            reverseDuration: Duration.zero,
            switchInCurve: kAnimationCurve,
            child: (state is VoluntaryPrayerLoading)
                ? LoadingWidget()
                : (state is VoluntaryPrayerLoaded)
                    ? SafeArea(
                        child: ListView(
                          padding: kPagePadding,
                          children: [
                            VoluntaryPrayerCard(
                              title: 'Ishraq',
                              subtitle:
                                  'Shortly after sunrise, once the sun has fully risen.',
                              startTime: state.voluntaryPrayerTimes.ishraq,
                            ),
                            VoluntaryPrayerCard(
                              title: 'Duha (Chasht)',
                              subtitle:
                                  'Mid-morning, until shortly before Dhuhr.',
                              startTime: state.voluntaryPrayerTimes.duhaStart,
                              endTime: state.voluntaryPrayerTimes.duhaEnd,
                            ),
                            VoluntaryPrayerCard(
                              title: 'Tahajjud',
                              subtitle:
                                  'Last third of the night - the most virtuous time for voluntary night prayer.',
                              startTime:
                                  state.voluntaryPrayerTimes.tahajjudStart,
                              endTime: state.voluntaryPrayerTimes.tahajjudEnd,
                            ),
                          ],
                        ),
                      )
                    : (state is VoluntaryPrayerFailed)
                        ? SafeArea(
                            child: FailureWidget(
                              state.failure,
                              () {
                                BlocProvider.of<LocationBloc>(context).add(
                                  InitLocation(),
                                );
                              },
                              withAppbar: true,
                            ),
                          )
                        : Container(),
          );
        },
      ),
    );
  }
}
