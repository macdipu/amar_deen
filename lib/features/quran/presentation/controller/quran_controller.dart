import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amar_deen/l10n/generated/app_localizations.dart';

import '../../../../core/di/injection.dart';
import '../../../../features/quran/domain/entities/quran.dart';
import '../../../../features/quran/domain/usecases/toggle_quran_favorite.dart';
import 'package:amar_deen/core/bloc/database/database_bloc.dart';
import '../bloc/quran_bloc/quran_bloc.dart';
import '../bloc/quran_audio_bloc/quran_audio_bloc.dart';

/// Returns false (instead of throwing) on DB failure so callers can surface
/// it to the user - a raw DB exception here would otherwise go unhandled
/// inside the async gesture callback that invokes this.
Future<bool> toggleQuranFavorite(BuildContext context, Quran quran) async {
  final db = BlocProvider.of<DatabaseBloc>(context).db;
  if (db == null) {
    return false;
  }

  try {
    final favoriteAyatIds = await getIt<ToggleQuranFavorite>()(db, quran);
    if (!context.mounted) return true;
    BlocProvider.of<QuranBloc>(context).add(
      SyncQuranFavorites(favoriteAyatIds),
    );
    return true;
  } catch (_) {
    return false;
  }
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
