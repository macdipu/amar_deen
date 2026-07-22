import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:amar_deen/core/bloc/location/location_bloc.dart';
import 'package:amar_deen/core/widgets/loading_widget.dart';
import '../widget/timing_screen_scaffold.dart';

class PrayerTimingScreen extends StatelessWidget {
  const PrayerTimingScreen();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        if (state is LocationLoading) {
          return Scaffold(
            body: LoadingWidget(),
          );
        }
        return TimingScreenScaffold();
      },
    );
  }
}
