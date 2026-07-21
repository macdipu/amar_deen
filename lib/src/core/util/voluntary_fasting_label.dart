import 'package:flutter/widgets.dart';
import 'package:sirat_e_mustaqeem/l10n/generated/app_localizations.dart';

import '../../../features/ramadan/domain/entities/voluntary_fasting_day.dart';

/// Maps a [VoluntaryFastingType] to its localized display label. Same
/// "keep the internal identifier in English, localize only the label at
/// render time" pattern as `prayer_name.dart`'s `localizedPrayerName` -
/// [VoluntaryFastingType] itself is a plain Dart enum (not a persisted
/// string key), but the same helper is shared between the UI list
/// (`VoluntaryFastingSection`) and the scheduled notification text
/// (`voluntary_fasting_reminder_service.dart`, built from a `BuildContext`
/// in `notification_controller.dart` before scheduling), so it belongs in
/// one place rather than being duplicated.
String voluntaryFastingTypeLabel(BuildContext context, VoluntaryFastingType type) {
  final l10n = AppLocalizations.of(context);
  switch (type) {
    case VoluntaryFastingType.monday:
      return l10n.voluntaryFastingMonday;
    case VoluntaryFastingType.thursday:
      return l10n.voluntaryFastingThursday;
    case VoluntaryFastingType.ayyamAlBeed:
      return l10n.voluntaryFastingAyyamAlBeed;
    case VoluntaryFastingType.arafah:
      return l10n.voluntaryFastingArafah;
  }
}
