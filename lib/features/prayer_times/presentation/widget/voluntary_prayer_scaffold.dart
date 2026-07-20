import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../src/core/util/bloc/location/location_bloc.dart';
import '../../../../src/core/util/bloc/prayer_time_config/prayer_time_config_bloc.dart';
import '../../../../src/core/util/constants.dart';
import '../../../../src/features/error/widget/failure_widget.dart';
import '../../../../src/features/utils/loading_widget.dart';
import 'package:sirat_e_mustaqeem/l10n/generated/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.voluntaryPrayersTitle),
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
                              title: l10n.voluntaryIshraqTitle,
                              subtitle: l10n.voluntaryIshraqSubtitle,
                              startTime: state.voluntaryPrayerTimes.ishraq,
                            ),
                            VoluntaryPrayerCard(
                              title: l10n.voluntaryDuhaTitle,
                              subtitle: l10n.voluntaryDuhaSubtitle,
                              startTime: state.voluntaryPrayerTimes.duhaStart,
                              endTime: state.voluntaryPrayerTimes.duhaEnd,
                            ),
                            VoluntaryPrayerCard(
                              title: l10n.voluntaryTahajjudTitle,
                              subtitle: l10n.voluntaryTahajjudSubtitle,
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
