import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tasbih_entity.dart';

part 'tasbih_event.dart';
part 'tasbih_state.dart';

class TasbihBloc extends Bloc<TasbihEvent, TasbihState> {
  TasbihBloc() : super(TasbihState(Tasbihs())) {
    on<TasbihEvent>((event, emit) async {
      if (event is FetchTasbih) {
        emit(TasbihState(event.tasbihs));
      }
      if (event is UpdateTasbih) {
        emit(TasbihState(event.tasbihs));
      }
    });
  }
}
