import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amar_deen/l10n/generated/app_localizations.dart';

import '../bloc/quran_bloc/quran_bloc.dart';
import '../bloc/quran_audio_bloc/quran_audio_bloc.dart';
import 'package:amar_deen/core/constants/constants.dart';
import '../bloc/quran_theme_bloc/quran_theme_bloc.dart';
import '../controller/quran_controller.dart';

class QuranAudioMiniPlayer extends StatelessWidget {
  const QuranAudioMiniPlayer({
    super.key,
    required this.surahId,
  });

  final int surahId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranAudioBloc, QuranAudioState>(
      builder: (context, audioState) {
        final isSameSurah = audioState.currentSurahId == surahId;
        final isActive = audioState.isActive && isSameSurah;
        final isPlaying = audioState.status == QuranAudioStatus.playing;
        final isLoading = audioState.status == QuranAudioStatus.loading;

        return SafeArea(
          top: false,
          child: Container(
            margin: EdgeInsets.only(
              left: 12.w,
              right: 12.w,
              bottom: 10.h,
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: kCardBorderRadius,
              border: Border.all(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.18),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    isActive
                        ? (audioState.currentAyatId != null
                            ? AppLocalizations.of(context)
                                .quranPlayingSurahAyah(
                                    surahId, audioState.currentAyatId!)
                            : AppLocalizations.of(context)
                                .quranPlayingSurah(surahId))
                        : AppLocalizations.of(context)
                            .quranPlayFullSurah(surahId),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                if (isActive)
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<QuranAudioBloc>(context)
                          .add(const StopAudio());
                    },
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                IconButton(
                  onPressed: () {
                    final bloc = BlocProvider.of<QuranAudioBloc>(context);
                    if (!isActive) {
                      final theme =
                          BlocProvider.of<QuranThemeBloc>(context).state;
                      final ayatIds = BlocProvider.of<QuranBloc>(context)
                          .state
                          .qurans
                          .getAyatIdsBySurah(surahId);
                      bloc.add(
                        PlaySurah(
                          surahId: surahId,
                          ayatIds: ayatIds,
                          edition: theme.audioEdition,
                          bitrate: theme.audioBitrate,
                        ),
                      );
                    } else {
                      bloc.add(const TogglePlayPause());
                    }

                    final error = bloc.state.error;
                    if (error != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text(localizedQuranAudioError(context, error)),
                        ),
                      );
                      bloc.add(const ClearAudioError());
                    }
                  },
                  icon: isLoading
                      ? SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.2,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : Icon(
                          isActive && isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_filled,
                          size: 34.sp,
                          color: Theme.of(context).primaryColor,
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
