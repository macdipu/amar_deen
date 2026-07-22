import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:amar_deen/l10n/generated/app_localizations.dart';

import 'package:amar_deen/core/di/injection.dart';
import 'package:amar_deen/core/routing/app_router.dart';
import 'package:amar_deen/core/bloc/location/location_bloc.dart';
import 'package:amar_deen/core/constants/constants.dart';
import 'package:amar_deen/core/widgets/elevated_button.dart';
import '../../domain/usecases/request_location_permission.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({super.key});

  Future<void> _continue(BuildContext context) async {
    context.pushReplacement(AppRoutes.notificationPermission);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final requestLocationPermission = getIt<RequestLocationPermission>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kPagePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 500.h,
                  maxHeight: 0.5.sh,
                ),
                child: LottieBuilder.asset(
                  'assets/images/permission/lottie_json/location_permission.json',
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              Text(
                l10n.permissionLocationTitle,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                l10n.permissionLocationBody,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 32.h,
              ),
              CustomElevatedButton(
                onPressed: () async {
                  final granted = await requestLocationPermission();
                  if (granted) {
                    BlocProvider.of<LocationBloc>(context).add(InitLocation());
                  }
                  await _continue(context);
                },
                text: l10n.permissionAllow,
              ),
              SizedBox(
                height: 8.h,
              ),
              TextButton(
                onPressed: () async {
                  await _continue(context);
                },
                child: Text(l10n.permissionNotNow),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
