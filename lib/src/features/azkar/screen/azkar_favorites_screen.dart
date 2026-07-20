import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_data_flutter/muslim_data_flutter.dart';
import 'package:sirat_e_mustaqeem/l10n/generated/app_localizations.dart';

import '../../../core/util/bloc/database/database_bloc.dart';
import '../../../core/util/constants.dart';
import '../../utils/loading_widget.dart';
import '../cubit/azkar_categories_cubit.dart';
import '../cubit/azkar_favorites_cubit.dart';
import '../widget/azkar_item_card.dart';

class AzkarFavoritesScreen extends StatelessWidget {
  const AzkarFavoritesScreen({super.key, required this.language});

  final Language language;

  @override
  Widget build(BuildContext context) {
    final db = BlocProvider.of<DatabaseBloc>(context).db;
    return BlocProvider(
      create: (_) {
        final cubit = AzkarFavoritesCubit(language: language);
        if (db != null) cubit.load(db);
        return cubit;
      },
      child: const _AzkarFavoritesView(),
    );
  }
}

class _AzkarFavoritesView extends StatelessWidget {
  const _AzkarFavoritesView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AzkarFavoritesCubit, AzkarFavoritesState>(
      builder: (context, state) {
        final l10n = AppLocalizations.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.azkarFavoriteAzkars),
          ),
          body: SafeArea(
            child: Builder(
              builder: (context) {
                if (state.status == AzkarLoadStatus.loading ||
                    state.status == AzkarLoadStatus.initial) {
                  return const LoadingWidget();
                }
                if (state.status == AzkarLoadStatus.error) {
                  return Center(
                    child: Text(
                      state.errorMessage ?? l10n.commonSomethingWentWrong,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                if (state.items.isEmpty) {
                  return Center(
                    child: Text(
                      l10n.azkarNoFavoritesYet,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  );
                }

                return ListView.separated(
                  padding: kPagePadding,
                  itemCount: state.items.length,
                  separatorBuilder: (_, __) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final item = state.items[index];

                    return AzkarItemCard(
                      item: item,
                      isFavorite: true,
                      onToggleFavorite: () {
                        final db =
                            BlocProvider.of<DatabaseBloc>(context).db;
                        if (db == null) return;
                        context
                            .read<AzkarFavoritesCubit>()
                            .toggleFavorite(db, item);
                      },
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
