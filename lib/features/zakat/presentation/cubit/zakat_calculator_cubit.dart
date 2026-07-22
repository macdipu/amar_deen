import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/di/injection.dart';
import '../../domain/entities/zakat_result.dart';
import '../../domain/usecases/calculate_zakat.dart';

class ZakatCalculatorState extends Equatable {
  final double cashAndBankSavings;
  final double goldWeightGrams;
  final double goldPricePerGram;
  final double silverWeightGrams;
  final double silverPricePerGram;
  final double businessAssets;
  final double otherInvestments;
  final double debtsOwed;

  /// Null until [ZakatCalculatorCubit.calculate] is called, and reset to
  /// null whenever any input changes - so the displayed result always
  /// reflects the currently-entered values, never a stale calculation.
  final ZakatResult? result;

  const ZakatCalculatorState({
    this.cashAndBankSavings = 0,
    this.goldWeightGrams = 0,
    this.goldPricePerGram = 0,
    this.silverWeightGrams = 0,
    this.silverPricePerGram = 0,
    this.businessAssets = 0,
    this.otherInvestments = 0,
    this.debtsOwed = 0,
    this.result,
  });

  ZakatCalculatorState copyWith({
    double? cashAndBankSavings,
    double? goldWeightGrams,
    double? goldPricePerGram,
    double? silverWeightGrams,
    double? silverPricePerGram,
    double? businessAssets,
    double? otherInvestments,
    double? debtsOwed,
    ZakatResult? result,
  }) {
    return ZakatCalculatorState(
      cashAndBankSavings: cashAndBankSavings ?? this.cashAndBankSavings,
      goldWeightGrams: goldWeightGrams ?? this.goldWeightGrams,
      goldPricePerGram: goldPricePerGram ?? this.goldPricePerGram,
      silverWeightGrams: silverWeightGrams ?? this.silverWeightGrams,
      silverPricePerGram: silverPricePerGram ?? this.silverPricePerGram,
      businessAssets: businessAssets ?? this.businessAssets,
      otherInvestments: otherInvestments ?? this.otherInvestments,
      debtsOwed: debtsOwed ?? this.debtsOwed,
      result: result,
    );
  }

  @override
  List<Object?> get props => [
        cashAndBankSavings,
        goldWeightGrams,
        goldPricePerGram,
        silverWeightGrams,
        silverPricePerGram,
        businessAssets,
        otherInvestments,
        debtsOwed,
        result,
      ];
}

class ZakatCalculatorCubit extends Cubit<ZakatCalculatorState> {
  final CalculateZakat _calculateZakat;

  ZakatCalculatorCubit({CalculateZakat? calculateZakat})
      : _calculateZakat = calculateZakat ?? getIt<CalculateZakat>(),
        super(const ZakatCalculatorState());

  void updateCashAndBankSavings(double value) =>
      emit(state.copyWith(cashAndBankSavings: value));
  void updateGoldWeightGrams(double value) =>
      emit(state.copyWith(goldWeightGrams: value));
  void updateGoldPricePerGram(double value) =>
      emit(state.copyWith(goldPricePerGram: value));
  void updateSilverWeightGrams(double value) =>
      emit(state.copyWith(silverWeightGrams: value));
  void updateSilverPricePerGram(double value) =>
      emit(state.copyWith(silverPricePerGram: value));
  void updateBusinessAssets(double value) =>
      emit(state.copyWith(businessAssets: value));
  void updateOtherInvestments(double value) =>
      emit(state.copyWith(otherInvestments: value));
  void updateDebtsOwed(double value) => emit(state.copyWith(debtsOwed: value));

  void calculate() {
    final result = _calculateZakat(
      cashAndBankSavings: state.cashAndBankSavings,
      goldWeightGrams: state.goldWeightGrams,
      goldPricePerGram: state.goldPricePerGram,
      silverWeightGrams: state.silverWeightGrams,
      silverPricePerGram: state.silverPricePerGram,
      businessAssets: state.businessAssets,
      otherInvestments: state.otherInvestments,
      debtsOwed: state.debtsOwed,
    );
    emit(state.copyWith(result: result));
  }
}
