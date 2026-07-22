import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'core/di/injection.dart';
import 'core/localization/locale_bloc/locale_bloc.dart';
import 'core/routing/app_router.dart';
import 'core/theme/theme_bloc/theme_bloc.dart';
import 'features/prayer_times/presentation/bloc/azan_settings_bloc/azan_settings_bloc.dart';
import 'l10n/generated/app_localizations.dart';
import 'package:amar_deen/core/notifications/notification_service.dart';
import 'package:amar_deen/core/bloc/daily_reminder/daily_reminder_bloc.dart';
import 'package:amar_deen/core/bloc/database/database_bloc.dart';
import 'features/dua_azkar/presentation/dua/bloc/dua_bloc/dua_bloc.dart';
import 'features/quran/presentation/bloc/juz_bloc/juz_bloc.dart';
import 'package:amar_deen/core/bloc/location/location_bloc.dart';
import 'package:amar_deen/core/bloc/notification/notification_bloc.dart';
import 'features/prayer_times/presentation/bloc/timing_bloc/timing_bloc.dart';
import 'features/prayer_times/presentation/bloc/prayer_time_config_bloc/prayer_time_config_bloc.dart';
import 'features/quran/presentation/bloc/quran_bloc/quran_bloc.dart';
import 'features/quran/presentation/bloc/quran_audio_bloc/quran_audio_bloc.dart';
import 'features/quran/presentation/bloc/surah_bloc/surah_bloc.dart';
import 'features/tasbih/presentation/bloc/tasbih_bloc/tasbih_bloc.dart';
import 'package:amar_deen/core/bloc/time_format/time_format_bloc.dart';
import 'features/allah_name/presentation/bloc/allah_name_bloc/allah_name_bloc.dart';
import 'features/bottom_tab/presentation/bloc/tab_bloc/tab_bloc.dart';
import 'features/quran/presentation/bloc/quran_theme_bloc/quran_theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  configureDependencies();
  await NotificationService().init();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
        (await getApplicationDocumentsDirectory()).path),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (context) => LocaleBloc(),
        ),
        BlocProvider(
          create: (context) => TimeFormatBloc(),
        ),
        BlocProvider(
          create: (context) => NotificationBloc(),
        ),
        BlocProvider(
          create: (context) => QuranThemeBloc(),
        ),
        BlocProvider(
          create: (context) => TimingBloc(),
        ),
        BlocProvider(
          create: (context) => PrayerTimeConfigBloc(),
        ),
        BlocProvider(
          create: (context) => AzanSettingsBloc(),
        ),
        BlocProvider(
          create: (context) => AllahNameBloc(),
        ),
        BlocProvider(
          create: (context) => DuaBloc(),
        ),
        BlocProvider(
          create: (context) => QuranBloc(),
        ),
        BlocProvider(
          create: (context) => QuranAudioBloc(),
        ),
        BlocProvider(
          create: (context) => SurahBloc(),
        ),
        BlocProvider(
          create: (context) => TasbihBloc(),
        ),
        BlocProvider(
          create: (context) => JuzBloc(),
        ),
        BlocProvider(
          create: (context) => DatabaseBloc(),
        ),
        BlocProvider(
          create: (context) => TabBloc(),
        ),
        BlocProvider(
          create: (context) => LocationBloc(),
        ),
        BlocProvider(
          create: (context) => DailyReminderBloc(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(414, 896),
        builder: (context, child) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return BlocBuilder<LocaleBloc, LocaleState>(
                builder: (context, localeState) {
                  return MaterialApp.router(
                    title: 'Amar Deen',
                    debugShowCheckedModeBanner: false,
                    color: Colors.white,
                    theme: themeState.currentTheme,
                    locale: localeState.locale,
                    supportedLocales: kSupportedLocales,
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    routerConfig: appRouter,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
