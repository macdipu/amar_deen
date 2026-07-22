import 'package:flutter/widgets.dart';
import 'package:muslim_data_flutter/muslim_data_flutter.dart';
import 'package:amar_deen/l10n/generated/app_localizations.dart';

const List<Language> azkarSupportedLanguages = [
  Language.en,
  Language.ar,
  Language.ckb,
  Language.ckbBadini,
  Language.fa,
  Language.ru,
];

String azkarLanguageLabel(BuildContext context, Language language) {
  final l10n = AppLocalizations.of(context);
  switch (language) {
    case Language.en:
      return l10n.azkarLanguageEnglish;
    case Language.ar:
      return l10n.azkarLanguageArabic;
    case Language.ckb:
      return l10n.azkarLanguageKurdishSorani;
    case Language.ckbBadini:
      return l10n.azkarLanguageKurdishBadini;
    case Language.fa:
      return l10n.azkarLanguagePersian;
    case Language.ru:
      return l10n.azkarLanguageRussian;
    default:
      return language.name.toUpperCase();
  }
}
