import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:amar_deen/l10n/generated/app_localizations.dart';

import '../../../../core/di/injection.dart';
import 'package:amar_deen/core/utils/voluntary_fasting_label.dart';
import '../../domain/entities/voluntary_fasting_day.dart';
import '../../domain/usecases/get_upcoming_voluntary_fasting_days.dart';

/// Read-only list of the next occurrence of each voluntary fasting day
/// type - a pure, synchronous, on-device computation (see
/// `VoluntaryFastingRepositoryImpl`), so this skips a dedicated Bloc/Cubit
/// entirely and just calls the use case straight from `build()`, per this
/// codebase's own convention that simple synchronous reads don't need
/// Either/bloc ceremony (see `CLAUDE.md`).
class VoluntaryFastingSection extends StatelessWidget {
  const VoluntaryFastingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final days = getIt<GetUpcomingVoluntaryFastingDays>()();
    if (days.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.h),
        Text(
          l10n.voluntaryFastingSectionTitle,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 8.h),
        ...days.map((day) => _VoluntaryFastingTile(day: day)),
      ],
    );
  }
}

class _VoluntaryFastingTile extends StatelessWidget {
  const _VoluntaryFastingTile({required this.day});

  final VoluntaryFastingDay day;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            voluntaryFastingTypeLabel(context, day.type),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          Text(
            DateFormat('d MMMM yyyy').format(day.date),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}
