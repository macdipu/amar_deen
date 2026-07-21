import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sirat_e_mustaqeem/l10n/generated/app_localizations.dart';

import '../../../../src/core/util/constants.dart';
import '../../domain/entities/ramadan_times_entity.dart';

/// Live-updating "time left" banner for the Ramadan screen - counts down
/// to whichever of Suhoor-end (Imsak) or Iftar is next, switching targets
/// automatically as the day passes. Mirrors the app bar countdown pattern
/// in `home/widget/upcoming_prayer_text.dart` (same 30s `Timer.periodic`
/// tick, same duration-formatting helper), but rendered as a standalone
/// card since this screen has room for it to be prominent.
class RamadanCountdown extends StatefulWidget {
  const RamadanCountdown({super.key, required this.ramadanTimes});

  final RamadanTimesEntity ramadanTimes;

  @override
  State<RamadanCountdown> createState() => _RamadanCountdownState();
}

class _RamadanCountdownState extends State<RamadanCountdown> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  static String _formatDuration(AppLocalizations l10n, Duration d) {
    if (d.isNegative) return l10n.homeMinutesRemaining(0);
    if (d.inMinutes < 1) return l10n.homeLessThanAMinute;
    if (d.inMinutes < 60) {
      return l10n.homeMinutesRemaining(d.inMinutes);
    }
    final h = d.inHours;
    final mins = d.inMinutes.remainder(60);
    if (mins == 0) {
      return l10n.homeHoursRemaining(h);
    }
    return '${l10n.homeHoursRemaining(h)} ${l10n.homeMinutesRemaining(mins)}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final now = DateTime.now();
    final imsak = widget.ramadanTimes.imsak;
    final iftar = widget.ramadanTimes.iftar;

    final String label;
    final DateTime target;
    if (now.isBefore(imsak)) {
      label = l10n.ramadanSuhoorEndsIn;
      target = imsak;
    } else if (now.isBefore(iftar)) {
      label = l10n.ramadanIftarIn;
      target = iftar;
    } else {
      label = l10n.ramadanSuhoorEndsIn;
      // Approximate tomorrow's Imsak using today's hour/minute - same
      // approximation `upcoming_prayer_text.dart` uses for its Fajr
      // wraparound, since Imsak barely shifts day to day.
      target = DateTime(
        now.year,
        now.month,
        now.day + 1,
        imsak.hour,
        imsak.minute,
      );
    }

    final durationStr = _formatDuration(l10n, target.difference(now));

    return Container(
      width: double.infinity,
      padding: kCardPadding,
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withValues(alpha: 0.12),
        borderRadius: kCardBorderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          Text(
            durationStr,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
