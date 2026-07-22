import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amar_deen/l10n/generated/app_localizations.dart';

import 'package:amar_deen/core/constants/constants.dart';
import '../cubit/zakat_calculator_cubit.dart';

class ZakatCalculatorScreen extends StatelessWidget {
  const ZakatCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ZakatCalculatorCubit(),
      child: const _ZakatCalculatorView(),
    );
  }
}

class _ZakatCalculatorView extends StatelessWidget {
  const _ZakatCalculatorView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.zakatAppBarTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: kPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              Text(
                l10n.zakatDisclaimer,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.color
                          ?.withValues(alpha: 0.75),
                    ),
              ),
              SizedBox(height: 16.h),
              _ZakatNumberField(
                label: l10n.zakatCashLabel,
                onChanged: (context, value) => context
                    .read<ZakatCalculatorCubit>()
                    .updateCashAndBankSavings(value),
              ),
              _ZakatNumberField(
                label: l10n.zakatGoldWeightLabel,
                onChanged: (context, value) => context
                    .read<ZakatCalculatorCubit>()
                    .updateGoldWeightGrams(value),
              ),
              _ZakatNumberField(
                label: l10n.zakatGoldPriceLabel,
                onChanged: (context, value) => context
                    .read<ZakatCalculatorCubit>()
                    .updateGoldPricePerGram(value),
              ),
              _ZakatNumberField(
                label: l10n.zakatSilverWeightLabel,
                onChanged: (context, value) => context
                    .read<ZakatCalculatorCubit>()
                    .updateSilverWeightGrams(value),
              ),
              _ZakatNumberField(
                label: l10n.zakatSilverPriceLabel,
                onChanged: (context, value) => context
                    .read<ZakatCalculatorCubit>()
                    .updateSilverPricePerGram(value),
              ),
              _ZakatNumberField(
                label: l10n.zakatBusinessAssetsLabel,
                onChanged: (context, value) => context
                    .read<ZakatCalculatorCubit>()
                    .updateBusinessAssets(value),
              ),
              _ZakatNumberField(
                label: l10n.zakatInvestmentsLabel,
                onChanged: (context, value) => context
                    .read<ZakatCalculatorCubit>()
                    .updateOtherInvestments(value),
              ),
              _ZakatNumberField(
                label: l10n.zakatDebtsLabel,
                onChanged: (context, value) =>
                    context.read<ZakatCalculatorCubit>().updateDebtsOwed(value),
              ),
              SizedBox(height: 8.h),
              ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  minimumSize:
                      WidgetStateProperty.all(Size(double.infinity, 48.h)),
                ),
                onPressed: () =>
                    context.read<ZakatCalculatorCubit>().calculate(),
                child: Text(l10n.zakatCalculateButton),
              ),
              SizedBox(height: 16.h),
              BlocBuilder<ZakatCalculatorCubit, ZakatCalculatorState>(
                builder: (context, state) {
                  final result = state.result;
                  if (result == null) return const SizedBox.shrink();

                  return Container(
                    width: double.infinity,
                    padding: kCardPadding,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: kCardBorderRadius,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ZakatResultRow(
                          label: l10n.zakatResultZakatableWealth,
                          value: result.zakatableWealth.toStringAsFixed(2),
                        ),
                        SizedBox(height: 8.h),
                        _ZakatResultRow(
                          label: l10n.zakatResultNisabThreshold,
                          value: result.nisabThreshold.toStringAsFixed(2),
                        ),
                        Divider(height: 24.h),
                        Text(
                          result.isZakatDue
                              ? l10n.zakatResultDue
                              : l10n.zakatResultNotDue,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        if (result.isZakatDue) ...[
                          SizedBox(height: 8.h),
                          _ZakatResultRow(
                            label: l10n.zakatResultAmount,
                            value: result.zakatAmount.toStringAsFixed(2),
                            emphasize: true,
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _ZakatResultRow extends StatelessWidget {
  const _ZakatResultRow({
    required this.label,
    required this.value,
    this.emphasize = false,
  });

  final String label;
  final String value;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    final valueStyle = emphasize
        ? Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            )
        : Theme.of(context).textTheme.bodyLarge;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodyMedium)),
        Text(value, style: valueStyle),
      ],
    );
  }
}

class _ZakatNumberField extends StatelessWidget {
  const _ZakatNumberField({
    required this.label,
    required this.onChanged,
  });

  final String label;
  final void Function(BuildContext context, double value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: TextField(
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
        onChanged: (text) => onChanged(context, double.tryParse(text) ?? 0),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          contentPadding: kInputFieldPadding,
        ),
      ),
    );
  }
}
