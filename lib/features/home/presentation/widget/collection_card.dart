import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart'
    show AlignedGridView;

import 'package:amar_deen/l10n/generated/app_localizations.dart';

import 'package:amar_deen/core/widgets/sirat_card.dart';
import '../../domain/utils/build_collection_items.dart';
import 'collection_button.dart';

class CollectionCard extends StatelessWidget {
  const CollectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final collections = buildCollectionItems(context);
    return SiratCard(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l10n.homeCollectionSectionTitle,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(
            height: 16.h,
          ),
          AlignedGridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemCount: collections.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return CollectionButton(
                collections[index],
              );
            },
          ),
        ],
      ),
    );
  }
}
