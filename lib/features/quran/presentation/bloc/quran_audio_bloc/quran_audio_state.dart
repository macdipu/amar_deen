part of 'quran_audio_bloc.dart';

enum QuranAudioStatus { idle, loading, playing, paused, stopped, error }

enum QuranAudioMode { none, ayah, surah }

/// Error kind for [QuranAudioState.error]. Kept as an enum (not a raw
/// message string) so widgets can localize it via `AppLocalizations` at
/// display time instead of the bloc emitting hardcoded English text.
enum QuranAudioError { noInternet, playbackFailed, surahPlaybackFailed }

class QuranAudioState extends Equatable {
  final QuranAudioStatus status;
  final QuranAudioMode mode;
  final int? currentSurahId;
  final int? currentAyatId;
  final List<int> playlistAyatIds;
  final QuranAudioError? error;

  const QuranAudioState({
    this.status = QuranAudioStatus.idle,
    this.mode = QuranAudioMode.none,
    this.currentSurahId,
    this.currentAyatId,
    this.playlistAyatIds = const [],
    this.error,
  });

  /// [clearError] must be passed explicitly to null out [error] - omitting
  /// [error] otherwise preserves whatever error is already set, the same
  /// as every other field here, instead of silently wiping it on unrelated
  /// state transitions (e.g. track/player-state ticks).
  QuranAudioState copyWith({
    QuranAudioStatus? status,
    QuranAudioMode? mode,
    int? currentSurahId,
    int? currentAyatId,
    List<int>? playlistAyatIds,
    QuranAudioError? error,
    bool clearError = false,
  }) {
    return QuranAudioState(
      status: status ?? this.status,
      mode: mode ?? this.mode,
      currentSurahId: currentSurahId ?? this.currentSurahId,
      currentAyatId: currentAyatId ?? this.currentAyatId,
      playlistAyatIds: playlistAyatIds ?? this.playlistAyatIds,
      error: clearError ? null : (error ?? this.error),
    );
  }

  bool get isActive =>
      status == QuranAudioStatus.loading ||
      status == QuranAudioStatus.playing ||
      status == QuranAudioStatus.paused;

  @override
  List<Object?> get props => [
        status,
        mode,
        currentSurahId,
        currentAyatId,
        playlistAyatIds,
        error,
      ];
}
