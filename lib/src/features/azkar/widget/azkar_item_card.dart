import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_data_flutter/muslim_data_flutter.dart';

class AzkarItemCard extends StatelessWidget {
  const AzkarItemCard({
    super.key,
    required this.item,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  final AzkarItem item;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    final arabic = item.item;
    final translation = item.translation;
    final reference = item.reference;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 14.h,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.surface,
          width: 1.1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (arabic.isNotEmpty)
                Expanded(
                  child: Text(
                    arabic,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontFamily: 'Uthman',
                          height: 1.6,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              IconButton(
                onPressed: onToggleFavorite,
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Theme.of(context).primaryColor : null,
                ),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          if (translation.isNotEmpty)
            Text(
              translation,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.4,
                  ),
            ),
          if (reference.isNotEmpty) ...[
            SizedBox(height: 10.h),
            Text(
              reference,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.color
                        ?.withValues(alpha: 0.75),
                  ),
            ),
          ],
        ],
      ),
    );
  }
}
