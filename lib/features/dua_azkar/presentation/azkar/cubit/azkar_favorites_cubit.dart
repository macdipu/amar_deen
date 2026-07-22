import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_data_flutter/muslim_data_flutter.dart';
import 'package:sqflite/sqflite.dart';

import 'package:amar_deen/core/di/injection.dart';
import '../../../domain/azkar/entities/azkar_item_entity.dart';
import '../../../domain/azkar/usecases/get_azkar_favorites.dart';
import '../../../domain/azkar/usecases/toggle_azkar_favorite.dart';
import 'azkar_categories_cubit.dart';

class AzkarFavoritesState extends Equatable {
  final AzkarLoadStatus status;
  final Language language;
  final List<AzkarItemEntity> items;
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
    List<AzkarItemEntity>? items,
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

class AzkarFavoritesCubit extends Cubit<AzkarFavoritesState> {
  AzkarFavoritesCubit({
    required Language language,
    GetAzkarFavorites? getFavorites,
    ToggleAzkarFavorite? toggleFavorite,
  })  : _getFavorites = getFavorites ?? getIt<GetAzkarFavorites>(),
        _toggleFavorite = toggleFavorite ?? getIt<ToggleAzkarFavorite>(),
        super(AzkarFavoritesState.initial(language: language));

  final GetAzkarFavorites _getFavorites;
  final ToggleAzkarFavorite _toggleFavorite;

  Future<void> load(Database db) async {
    emit(state.copyWith(status: AzkarLoadStatus.loading, errorMessage: null));
    try {
      final items = await _getFavorites(db, language: state.language);
      emit(state.copyWith(status: AzkarLoadStatus.loaded, items: items));
    } catch (_) {
      emit(state.copyWith(
        status: AzkarLoadStatus.error,
        errorMessage: 'Unable to load favorite Azkars right now.',
      ));
    }
  }

  Future<void> toggleFavorite(Database db, AzkarItemEntity item) async {
    await _toggleFavorite(
      db,
      azkarItemId: item.id,
      chapterId: item.chapterId,
      language: state.language,
    );
    await load(db);
  }
}
