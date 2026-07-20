import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/routing/app_router.dart';
import '../../../core/util/bloc/database/database_bloc.dart';
import '../../../core/util/constants.dart';

class SplashScaffold extends StatelessWidget {
  const SplashScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DatabaseBloc, DatabaseState>(
      listener: (context, state) async {
        await Future.delayed(Duration(milliseconds: 750));
        if (state is DatabaseLoaded) {
          final locationPermission = await Permission.location.status;
          final notificationPermission = await Permission.notification.status;

          if (!locationPermission.isGranted) {
            context.pushReplacement(AppRoutes.locationPermission);
          } else if (!notificationPermission.isGranted) {
            context.pushReplacement(AppRoutes.notificationPermission);
          } else {
            context.pushReplacement(AppRoutes.tabScreen);
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
