import 'package:flutter/widgets.dart';
import 'package:sirat_e_mustaqeem/l10n/generated/app_localizations.dart';

/// Maps the English prayer-name keys used internally (as [TimingController]
/// list keys, [AzanSettingsBloc] toggle-map keys, and notification-scheduler
/// identifiers) to a localized display label. Keys are never localized
/// themselves - only this lookup, done at render time - so persisted state
/// keyed by these names (e.g. AzanSettingsBloc's HydratedBloc map) is
/// unaffected by the user's language setting.
String localizedPrayerName(BuildContext context, String key) {
  final l10n = AppLocalizations.of(context);
  switch (key) {
    case 'Fajr':
      return l10n.prayerFajr;
    case 'Sunrise':
      return l10n.prayerSunrise;
    case 'Dhuhr':
      return l10n.prayerDhuhr;
    case 'Asr':
      return l10n.prayerAsr;
    case 'Maghrib':
      return l10n.prayerMaghrib;
    case 'Isha':
      return l10n.prayerIsha;
    case 'Duha':
      return l10n.prayerDuha;
    case 'Ishraq':
      return l10n.prayerIshraq;
    case 'Tahajjud':
      return l10n.prayerTahajjud;
    default:
      return key;
  }
}
