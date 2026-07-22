import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amar_deen/l10n/generated/app_localizations.dart';

import '../../../../core/widgets/prayer_time_card.dart';
import 'package:amar_deen/core/bloc/location/location_bloc.dart';
import '../../../prayer_times/presentation/bloc/prayer_time_config_bloc/prayer_time_config_bloc.dart';
import 'package:amar_deen/core/constants/constants.dart';
import 'package:amar_deen/core/error/widgets/failure_widget.dart';
import 'package:amar_deen/core/widgets/loading_widget.dart';
import '../bloc/ramadan_bloc/ramadan_bloc.dart';
import 'ramadan_countdown.dart';
import 'voluntary_fasting_section.dart';

class RamadanScaffold extends StatefulWidget {
  const RamadanScaffold();

  @override
  State<RamadanScaffold> createState() => _RamadanScaffoldState();
}

class _RamadanScaffoldState extends State<RamadanScaffold> {
  @override
  void didChangeDependencies() {
    final prayerConfig = BlocProvider.of<PrayerTimeConfigBloc>(context).state;
    BlocProvider.of<RamadanBloc>(context).add(
      RequestRamadanTimes(
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
        title: Text(l10n.ramadanAppBarTitle),
      ),
      body: BlocBuilder<RamadanBloc, RamadanState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: kAnimationDuration,
            reverseDuration: Duration.zero,
            switchInCurve: kAnimationCurve,
            child: (state is RamadanLoading)
                ? LoadingWidget()
                : (state is RamadanLoaded)
                    ? SafeArea(
                        child: ListView(
                          padding: kPagePadding,
                          children: [
                            RamadanCountdown(ramadanTimes: state.ramadanTimes),
                            PrayerTimeCard(
                              title: l10n.ramadanSuhoorTitle,
                              subtitle: l10n.ramadanSuhoorSubtitle,
                              startTime: state.ramadanTimes.imsak,
                            ),
                            PrayerTimeCard(
                              title: l10n.ramadanIftarTitle,
                              subtitle: l10n.ramadanIftarSubtitle,
                              startTime: state.ramadanTimes.iftar,
                            ),
                            const VoluntaryFastingSection(),
                          ],
                        ),
                      )
                    : (state is RamadanFailed)
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
