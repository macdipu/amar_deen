import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_data_flutter/muslim_data_flutter.dart';
import 'package:sqflite/sqflite.dart';

import 'package:amar_deen/core/di/injection.dart';
import '../../../domain/azkar/entities/azkar_item_entity.dart';
import '../../../domain/azkar/usecases/get_azkar_favorite_item_ids.dart';
import '../../../domain/azkar/usecases/get_azkar_items.dart';
import '../../../domain/azkar/usecases/toggle_azkar_favorite.dart';
import 'azkar_categories_cubit.dart';

class AzkarItemsState extends Equatable {
  final AzkarLoadStatus status;
  final Language language;
  final int chapterId;
  final String chapterTitle;
  final List<AzkarItemEntity> items;
  final Set<int> favoriteItemIds;
  final String? errorMessage;

  const AzkarItemsState({
    required this.status,
    required this.language,
    required this.chapterId,
    required this.chapterTitle,
    required this.items,
    required this.favoriteItemIds,
    this.errorMessage,
  });

  factory AzkarItemsState.initial({
    required int chapterId,
    required String chapterTitle,
    required Language language,
  }) =>
      AzkarItemsState(
        status: AzkarLoadStatus.initial,
        language: language,
        chapterId: chapterId,
        chapterTitle: chapterTitle,
        items: const [],
        favoriteItemIds: const {},
      );

  AzkarItemsState copyWith({
    AzkarLoadStatus? status,
    List<AzkarItemEntity>? items,
    Set<int>? favoriteItemIds,
    String? errorMessage,
  }) {
    return AzkarItemsState(
      status: status ?? this.status,
      language: language,
      chapterId: chapterId,
      chapterTitle: chapterTitle,
      items: items ?? this.items,
      favoriteItemIds: favoriteItemIds ?? this.favoriteItemIds,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        language,
        chapterId,
        chapterTitle,
        items,
        favoriteItemIds,
        errorMessage,
      ];
}

class AzkarItemsCubit extends Cubit<AzkarItemsState> {
  AzkarItemsCubit({
    required int chapterId,
    required String chapterTitle,
    required Language language,
    GetAzkarItems? getItems,
    GetAzkarFavoriteItemIds? getFavoriteItemIds,
    ToggleAzkarFavorite? toggleFavorite,
  })  : _getItems = getItems ?? getIt<GetAzkarItems>(),
        _getFavoriteItemIds =
            getFavoriteItemIds ?? getIt<GetAzkarFavoriteItemIds>(),
        _toggleFavorite = toggleFavorite ?? getIt<ToggleAzkarFavorite>(),
        super(
          AzkarItemsState.initial(
            chapterId: chapterId,
            chapterTitle: chapterTitle,
            language: language,
          ),
        );

  final GetAzkarItems _getItems;
  final GetAzkarFavoriteItemIds _getFavoriteItemIds;
  final ToggleAzkarFavorite _toggleFavorite;

  Future<void> load({Database? db}) async {
    emit(state.copyWith(status: AzkarLoadStatus.loading, errorMessage: null));
    try {
      final items = await _getItems(
        language: state.language,
        chapterId: state.chapterId,
      );
      final favoriteItemIds = db == null
          ? <int>{}
          : (await _getFavoriteItemIds(db, language: state.language)).toSet();
      emit(state.copyWith(
        status: AzkarLoadStatus.loaded,
        items: items,
        favoriteItemIds: favoriteItemIds,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: AzkarLoadStatus.error,
        errorMessage: 'Unable to load Azkars right now.',
      ));
    }
  }

  Future<void> toggleFavorite(Database db, AzkarItemEntity item) async {
    final favoriteItemIds = await _toggleFavorite(
      db,
      azkarItemId: item.id,
      chapterId: item.chapterId,
      language: state.language,
    );
    emit(state.copyWith(favoriteItemIds: favoriteItemIds.toSet()));
  }
}
