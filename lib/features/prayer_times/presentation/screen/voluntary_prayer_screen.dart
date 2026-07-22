import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:amar_deen/core/bloc/location/location_bloc.dart';
import 'package:amar_deen/core/widgets/loading_widget.dart';
import '../bloc/voluntary_prayer_bloc/voluntary_prayer_bloc.dart';
import '../widget/voluntary_prayer_scaffold.dart';

class VoluntaryPrayerScreen extends StatelessWidget {
  const VoluntaryPrayerScreen();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VoluntaryPrayerBloc(),
      child: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state is LocationLoading) {
            return Scaffold(
              body: LoadingWidget(),
            );
          }
          return const VoluntaryPrayerScaffold();
        },
      ),
    );
  }
}
