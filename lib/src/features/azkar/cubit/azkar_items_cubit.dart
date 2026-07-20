import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_data_flutter/muslim_data_flutter.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/database/database_service.dart';
import '../repository/azkar_repository.dart';
import 'azkar_categories_cubit.dart';

class AzkarItemsState extends Equatable {
  final AzkarLoadStatus status;
  final Language language;
  final int chapterId;
  final String chapterTitle;
  final List<AzkarItem> items;
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
    List<AzkarItem>? items,
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
    AzkarRepository? repository,
  })  : _repository = repository ?? AzkarRepository(),
        super(
          AzkarItemsState.initial(
            chapterId: chapterId,
            chapterTitle: chapterTitle,
            language: language,
          ),
        );

  final AzkarRepository _repository;

  Future<void> load({Database? db}) async {
    emit(state.copyWith(status: AzkarLoadStatus.loading, errorMessage: null));
    try {
      final items = await _repository.getItems(
        language: state.language,
        chapterId: state.chapterId,
      );
      final favoriteItemIds = db == null
          ? <int>{}
          : (await DatabaseService().getAzkarFavoriteItemIds(
              db,
              language: state.language.value,
            ))
              .toSet();
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

  Future<void> toggleFavorite(Database db, AzkarItem item) async {
    final favoriteItemIds = await DatabaseService().toggleAzkarFavorite(
      db,
      azkarItemId: item.id,
      chapterId: item.chapterId,
      language: state.language.value,
    );
    emit(state.copyWith(favoriteItemIds: favoriteItemIds.toSet()));
  }
}
