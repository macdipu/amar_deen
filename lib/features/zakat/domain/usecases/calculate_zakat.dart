import 'package:injectable/injectable.dart';

import '../entities/zakat_result.dart';

/// Computes Zakat due using the standard 2.5% rate on zakatable wealth
/// held above the Nisab threshold. This calculator assumes the Hawl
/// (one full lunar year of possession) condition is already met - it
/// answers "how much is due", not "is it time yet".
///
/// **Content/convention judgment call, flagged for Dipu** (same treatment
/// as the Ishraq/Duha and Imsak minute offsets elsewhere in this app):
/// Nisab is computed from the silver standard (595g) rather than gold
/// (85g) - the commonly-cited, generally lower/more-inclusive threshold,
/// explicitly preferred in the Hanafi school. A calculator that let the
/// user pick either standard would be more complete but also more
/// complex; this is the simpler, single-standard v1.
///
/// Gold/silver prices are **not** fetched live - that would need a
/// network call (against this app's offline-first non-negotiable) and a
/// trustworthy priced-data source neither of which this build has. The
/// caller supplies the current price per gram, which the user can look
/// up separately.
@injectable
class CalculateZakat {
  const CalculateZakat();

  static const double zakatRate = 0.025; // 2.5%
  static const double nisabSilverGrams = 595;

  ZakatResult call({
    required double cashAndBankSavings,
    required double goldWeightGrams,
    required double goldPricePerGram,
    required double silverWeightGrams,
    required double silverPricePerGram,
    required double businessAssets,
    required double otherInvestments,
    required double debtsOwed,
  }) {
    final goldValue = goldWeightGrams * goldPricePerGram;
    final silverValue = silverWeightGrams * silverPricePerGram;

    final totalWealth = cashAndBankSavings +
        goldValue +
        silverValue +
        businessAssets +
        otherInvestments;

    final zakatableWealth =
        (totalWealth - debtsOwed) < 0 ? 0.0 : totalWealth - debtsOwed;

    final nisabThreshold = nisabSilverGrams * silverPricePerGram;

    final isDue = silverPricePerGram > 0 && zakatableWealth >= nisabThreshold;
    final zakatAmount = isDue ? zakatableWealth * zakatRate : 0.0;

    return ZakatResult(
      zakatableWealth: zakatableWealth,
      nisabThreshold: nisabThreshold,
      isZakatDue: isDue,
      zakatAmount: zakatAmount,
    );
  }
}
