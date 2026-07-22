import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_data_flutter/muslim_data_flutter.dart';

import 'package:amar_deen/core/di/injection.dart';
import '../../../domain/azkar/entities/azkar_chapter_entity.dart';
import '../../../domain/azkar/usecases/get_azkar_chapters.dart';
import 'azkar_categories_cubit.dart';

class AzkarChaptersState extends Equatable {
  final AzkarLoadStatus status;
  final Language language;
  final int categoryId;
  final String categoryTitle;
  final List<AzkarChapterEntity> chapters;
  final String? errorMessage;

  const AzkarChaptersState({
    required this.status,
    required this.language,
    required this.categoryId,
    required this.categoryTitle,
    required this.chapters,
    this.errorMessage,
  });

  factory AzkarChaptersState.initial({
    required int categoryId,
    required String categoryTitle,
    required Language language,
  }) =>
      AzkarChaptersState(
        status: AzkarLoadStatus.initial,
        language: language,
        categoryId: categoryId,
        categoryTitle: categoryTitle,
        chapters: const [],
      );

  AzkarChaptersState copyWith({
    AzkarLoadStatus? status,
    Language? language,
    List<AzkarChapterEntity>? chapters,
    String? errorMessage,
  }) {
    return AzkarChaptersState(
      status: status ?? this.status,
      language: language ?? this.language,
      categoryId: categoryId,
      categoryTitle: categoryTitle,
      chapters: chapters ?? this.chapters,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        language,
        categoryId,
        categoryTitle,
        chapters,
        errorMessage,
      ];
}

class AzkarChaptersCubit extends Cubit<AzkarChaptersState> {
  AzkarChaptersCubit({
    required int categoryId,
    required String categoryTitle,
    required Language language,
    GetAzkarChapters? getChapters,
  })  : _getChapters = getChapters ?? getIt<GetAzkarChapters>(),
        super(
          AzkarChaptersState.initial(
            categoryId: categoryId,
            categoryTitle: categoryTitle,
            language: language,
          ),
        );

  final GetAzkarChapters _getChapters;

  Future<void> load() async {
    emit(state.copyWith(status: AzkarLoadStatus.loading, errorMessage: null));
    try {
      final chapters = await _getChapters(
        language: state.language,
        categoryId: state.categoryId,
      );
      emit(state.copyWith(status: AzkarLoadStatus.loaded, chapters: chapters));
    } catch (_) {
      emit(state.copyWith(
        status: AzkarLoadStatus.error,
        errorMessage: 'Unable to load Azkar chapters right now.',
      ));
    }
  }
}
