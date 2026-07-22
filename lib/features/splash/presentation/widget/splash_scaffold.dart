import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:amar_deen/core/di/injection.dart';
import 'package:amar_deen/core/routing/app_router.dart';
import 'package:amar_deen/core/bloc/database/database_bloc.dart';
import 'package:amar_deen/core/constants/constants.dart';
import '../../domain/entities/splash_destination.dart';
import '../../domain/usecases/determine_splash_destination.dart';

class SplashScaffold extends StatelessWidget {
  SplashScaffold({super.key, DetermineSplashDestination? determineDestination})
      : determineDestination =
            determineDestination ?? getIt<DetermineSplashDestination>();

  final DetermineSplashDestination determineDestination;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DatabaseBloc, DatabaseState>(
      listener: (context, state) async {
        await Future.delayed(Duration(milliseconds: 750));
        if (state is DatabaseLoaded) {
          final destination = await determineDestination();
          switch (destination) {
            case SplashDestination.locationPermission:
              context.pushReplacement(AppRoutes.locationPermission);
              break;
            case SplashDestination.notificationPermission:
              context.pushReplacement(AppRoutes.notificationPermission);
              break;
            case SplashDestination.tabScreen:
              context.pushReplacement(AppRoutes.tabScreen);
              break;
          }
        } else if (state is DatabaseFailed) {
          context.pushReplacement(AppRoutes.databaseError);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // extendBodyBehindAppBar: true,
        // extendBody: true,
        // appBar: AppBar(
        //   // backgroundColor: Colors.black,
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   toolbarHeight: 0,
        //   systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
        // ),
        body: Center(
          child: ClipRRect(
            borderRadius: kAppIconBorderRadius,
            child: SvgPicture.asset(
              'assets/images/core/svg/splash.svg',
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
