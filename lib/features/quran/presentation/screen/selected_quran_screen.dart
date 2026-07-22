import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:amar_deen/core/constants/constants.dart';
import 'package:amar_deen/features/bottom_tab/presentation/bloc/tab_bloc/tab_bloc.dart';
import '../bloc/quran_theme_bloc/quran_theme_bloc.dart';
import '../bloc/selected_juz_bloc/selected_juz_bloc.dart';
import '../bloc/selected_surah_bloc/selected_surah_bloc.dart';
import '../cubit/quran_cubit.dart' as qc;
import '../cubit/quran_reading_cubit.dart';
import '../widget/juz_content.dart';
import '../widget/quran_audio_mini_player.dart';
import '../widget/surah_content.dart';
import 'option_screen.dart';
import '../bloc/quran_audio_bloc/quran_audio_bloc.dart';

class SelectedQuranScreen extends StatelessWidget {
  const SelectedQuranScreen({
    required this.surah,
    this.initialAyatId,
  });

  final bool surah;
  final int? initialAyatId;

  @override
  Widget build(BuildContext context) {
    final int? surahId = surah
        ? BlocProvider.of<SelectedSurahBloc>(context).state.surah.id
        : null;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            BlocProvider.of<QuranAudioBloc>(context).add(const StopAudio());
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if (!BlocProvider.of<qc.QuranCubit>(context).state.fromNav)
                Navigator.of(context).pop();
              Navigator.of(context).pop();
              BlocProvider.of<TabBloc>(context).add(SetTab(3));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: SvgPicture.asset(
                'assets/images/navigation_icon/svg/bookmark_nfill.svg',
                width: 24.w,
                color: kDarkTextColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OptionScreen(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: SvgPicture.asset(
                'assets/images/navigation_icon/svg/setting_nfill.svg',
                width: 24.w,
                color: kDarkTextColor,
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<QuranThemeBloc, QuranThemeState>(
        builder: (context, themeState) {
          final isQcfHorizontal = themeState.quranType == 'QCF' &&
              themeState.qcfScrollDirection == 'Horizontal';

          final axis = isQcfHorizontal ? Axis.horizontal : Axis.vertical;

          final content = surah
              ? SurahContent(
                  scrollDirection: axis,
                  initialAyatId: initialAyatId,
                  onLastAyatChanged: (ayatId) {
                    final surahId = BlocProvider.of<SelectedSurahBloc>(context)
                        .state
                        .surah
                        .id;
                    BlocProvider.of<QuranReadingCubit>(context)
                        .saveSurahReading(surahId: surahId, ayatId: ayatId);
                  },
                )
              : JuzContent(
                  scrollDirection: axis,
                  initialAyatId: initialAyatId,
                  onLastAyatChanged: (ayatId) {
                    final juzId =
                        BlocProvider.of<SelectedJuzBloc>(context).state.juz.id;
                    BlocProvider.of<QuranReadingCubit>(context)
                        .saveJuzReading(juzId: juzId, ayatId: ayatId);
                  },
                );

          if (!surah || surahId == null) {
            return content;
          }

          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 86.h),
                child: content,
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: QuranAudioMiniPlayer(surahId: surahId),
              ),
            ],
          );
        },
      ),
    );
  }
}
