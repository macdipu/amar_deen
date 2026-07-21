import 'package:equatable/equatable.dart';

/// Result of a Zakat calculation - see `CalculateZakat` for the formula.
class ZakatResult extends Equatable {
  /// Total wealth (cash + gold + silver + business assets + investments)
  /// minus debts owed, clamped to a minimum of 0.
  final double zakatableWealth;

  /// The Nisab threshold (silver standard) below which no Zakat is due.
  final double nisabThreshold;

  final bool isZakatDue;

  /// 2.5% of [zakatableWealth] if [isZakatDue], else 0.
  final double zakatAmount;

  const ZakatResult({
    required this.zakatableWealth,
    required this.nisabThreshold,
    required this.isZakatDue,
    required this.zakatAmount,
  });

  @override
  List<Object> get props =>
      [zakatableWealth, nisabThreshold, isZakatDue, zakatAmount];
}
