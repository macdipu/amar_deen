import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amar_deen/l10n/generated/app_localizations.dart';

import 'package:amar_deen/core/bloc/location/location_bloc.dart';
import '../bloc/timing_bloc/timing_bloc.dart';
import 'package:amar_deen/core/constants/constants.dart';
import 'package:amar_deen/core/error/widgets/failure_widget.dart';
import 'package:amar_deen/core/widgets/loading_widget.dart';
import 'success_widget.dart';

class TimingScreenScaffold extends StatelessWidget {
  const TimingScreenScaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context)
            .appBarTheme
            .backgroundColor!
            .withValues(alpha: 0.3),
        elevation: 0,
        title: Text(AppLocalizations.of(context).prayerTimingAppBarTitle),
      ),
      body: BlocBuilder<TimingBloc, TimingState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: kAnimationDuration,
            reverseDuration: Duration.zero,
            switchInCurve: kAnimationCurve,
            child: (state is TimingLoading)
                ? LoadingWidget()
                : (state is TimingLoaded)
                    ? SuccessWidget(state.prayerTimes)
                    : (state is TimingFailed)
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
