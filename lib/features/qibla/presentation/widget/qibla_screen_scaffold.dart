import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:amar_deen/core/bloc/location/location_bloc.dart';
import 'package:amar_deen/core/constants/constants.dart';
import 'package:amar_deen/core/error/widgets/failure_widget.dart';
import 'package:amar_deen/core/widgets/loading_widget.dart';
import 'package:amar_deen/l10n/generated/app_localizations.dart';

import '../../domain/utils/direction_text.dart';
import '../bloc/qibla_bloc/qibla_bloc.dart';
import 'compass.dart';

class QiblaScaffold extends StatefulWidget {
  const QiblaScaffold();

  @override
  State<QiblaScaffold> createState() => _QiblaScaffoldState();
}

class _QiblaScaffoldState extends State<QiblaScaffold> {
  String _localizedDirection(AppLocalizations l10n, String key) {
    switch (key) {
      case 'North':
        return l10n.qiblaDirectionNorth;
      case 'North-East':
        return l10n.qiblaDirectionNorthEast;
      case 'East':
        return l10n.qiblaDirectionEast;
      case 'South-East':
        return l10n.qiblaDirectionSouthEast;
      case 'South':
        return l10n.qiblaDirectionSouth;
      case 'South-West':
        return l10n.qiblaDirectionSouthWest;
      case 'West':
        return l10n.qiblaDirectionWest;
      case 'North-West':
        return l10n.qiblaDirectionNorthWest;
      default:
        return '';
    }
  }

  @override
  void didChangeDependencies() {
    BlocProvider.of<QiblaBloc>(context).add(
      RequestQiblahDirection(
        BlocProvider.of<LocationBloc>(context).state,
      ),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(l10n.qiblaTitle),
      ),
      body: BlocBuilder<QiblaBloc, QiblaState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: kAnimationDuration,
            reverseDuration: Duration.zero,
            switchInCurve: kAnimationCurve,
            child: (state is QiblaLoading)
                ? LoadingWidget()
                : (state is QiblaLoaded)
                    ? SafeArea(
                        child: Container(
                          width: 1.sw,
                          padding: kPagePadding,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 32.h,
                                  ),
                                  Text(l10n.qiblaDirectionIs),
                                  Text(
                                    '${state.direction.toStringAsFixed(0)}°',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  Text(
                                    _localizedDirection(
                                      l10n,
                                      getDirectionKey(
                                        state.direction.floor(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Compass(
                                  heading: state.heading,
                                  qiblah: state.direction,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : (state is QiblaFailed)
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
