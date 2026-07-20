import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_data_flutter/muslim_data_flutter.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/database/database_service.dart';
import '../repository/azkar_repository.dart';
import 'azkar_categories_cubit.dart';

class AzkarFavoritesState extends Equatable {
  final AzkarLoadStatus status;
  final Language language;
  final List<AzkarItem> items;
  final String? errorMessage;

  const AzkarFavoritesState({
    required this.status,
    required this.language,
    required this.items,
    this.errorMessage,
  });

  factory AzkarFavoritesState.initial({required Language language}) =>
      AzkarFavoritesState(
        status: AzkarLoadStatus.initial,
        language: language,
        items: const [],
      );

  AzkarFavoritesState copyWith({
    AzkarLoadStatus? status,
    List<AzkarItem>? items,
    String? errorMessage,
  }) {
    return AzkarFavoritesState(
      status: status ?? this.status,
      language: language,
      items: items ?? this.items,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, language, items, errorMessage];
}

/// Loads the user's favorited Azkar items. There's no "get azkar item by
/// id" lookup in `muslim_data_flutter`, only per-chapter, so this fetches
/// each distinct favorited chapter once and filters down to the
/// favorited item ids within it.
class AzkarFavoritesCubit extends Cubit<AzkarFavoritesState> {
  AzkarFavoritesCubit({
    required Language language,
    AzkarRepository? repository,
  })  : _repository = repository ?? AzkarRepository(),
        super(AzkarFavoritesState.initial(language: language));

  final AzkarRepository _repository;

  Future<void> load(Database db) async {
    emit(state.copyWith(status: AzkarLoadStatus.loading, errorMessage: null));
    try {
      final refs = await DatabaseService().getAzkarFavoriteRefs(
        db,
        language: state.language.value,
      );

      final favoriteItemIds = refs
          .map((row) => row['azkar_item_id'] as int)
          .toSet();
      final chapterIds =
          refs.map((row) => row['chapter_id'] as int).toSet();

      final items = <AzkarItem>[];
      for (final chapterId in chapterIds) {
        final chapterItems = await _repository.getItems(
          language: state.language,
          chapterId: chapterId,
        );
        items.addAll(
          chapterItems.where((item) => favoriteItemIds.contains(item.id)),
        );
      }

      emit(state.copyWith(status: AzkarLoadStatus.loaded, items: items));
    } catch (_) {
      emit(state.copyWith(
        status: AzkarLoadStatus.error,
        errorMessage: 'Unable to load favorite Azkars right now.',
      ));
    }
  }

  Future<void> toggleFavorite(Database db, AzkarItem item) async {
    await DatabaseService().toggleAzkarFavorite(
      db,
      azkarItemId: item.id,
      chapterId: item.chapterId,
      language: state.language.value,
    );
    await load(db);
  }
}
