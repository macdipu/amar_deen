import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirat_e_mustaqeem/l10n/generated/app_localizations.dart';

import '../../../../core/di/injection.dart';
import '../../../../features/quran/domain/entities/quran.dart';
import '../../../../features/quran/domain/usecases/toggle_quran_favorite.dart';
import '../../../core/util/bloc/database/database_bloc.dart';
import '../../../core/util/bloc/quran/quran_bloc.dart';
import '../../../core/util/bloc/quran_audio/quran_audio_bloc.dart';

Future<void> toggleQuranFavorite(BuildContext context, Quran quran) async {
  final db = BlocProvider.of<DatabaseBloc>(context).db;
  if (db == null) {
    return;
  }

  final favoriteAyatIds = await getIt<ToggleQuranFavorite>()(db, quran);
  BlocProvider.of<QuranBloc>(context).add(
    SyncQuranFavorites(favoriteAyatIds),
  );
}

String localizedQuranAudioError(BuildContext context, QuranAudioError error) {
  final l10n = AppLocalizations.of(context);
  switch (error) {
    case QuranAudioError.noInternet:
      return l10n.quranAudioNoInternet;
    case QuranAudioError.playbackFailed:
      return l10n.quranAudioPlaybackFailed;
    case QuranAudioError.surahPlaybackFailed:
      return l10n.quranAudioSurahPlaybackFailed;
  }
}

/// Maps [Surah.place]'s normalized internal value ('Makki'/'Madina', see
/// `Surahs._normalizePlace`) to a localized display label.
String localizedSurahPlace(BuildContext context, String place) {
  final l10n = AppLocalizations.of(context);
  switch (place) {
    case 'Makki':
      return l10n.quranPlaceMakki;
    case 'Madina':
      return l10n.quranPlaceMadina;
    default:
      return place;
  }
}

String quranSurahMetaLabel(BuildContext context, String place, int ayats) {
  return AppLocalizations.of(context)
      .quranSurahMeta(localizedSurahPlace(context, place), ayats);
}
