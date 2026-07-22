part of 'dua_bloc.dart';

abstract class DuaEvent extends Equatable {
  const DuaEvent();

  @override
  List<Object> get props => [];
}

/// Loads the full Dua collection (categorized by surah) into state.
class FetchDua extends DuaEvent {
  final Duas duas;

  const FetchDua(this.duas);

  @override
  List<Object> get props => [duas];
}

/// Replaces state with the Dua collection returned after a favorite toggle.
class UpdateDua extends DuaEvent {
  final Duas duas;

  const UpdateDua(this.duas);

  @override
  List<Object> get props => [duas];
}
