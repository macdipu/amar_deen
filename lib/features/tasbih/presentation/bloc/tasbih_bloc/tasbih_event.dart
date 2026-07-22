part of 'tasbih_bloc.dart';

abstract class TasbihEvent extends Equatable {
  const TasbihEvent();

  @override
  List<Object> get props => [];
}

class FetchTasbih extends TasbihEvent {
  final Tasbihs tasbihs;

  const FetchTasbih(this.tasbihs);

  @override
  List<Object> get props => [tasbihs];
}

class UpdateTasbih extends TasbihEvent {
  final Tasbihs tasbihs;

  const UpdateTasbih(this.tasbihs);

  @override
  List<Object> get props => [tasbihs];
}
