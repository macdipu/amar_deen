import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/dua/entities/dua_entity.dart';

part 'dua_event.dart';
part 'dua_state.dart';

class DuaBloc extends Bloc<DuaEvent, DuaState> {
  DuaBloc() : super(DuaState(Duas())) {
    on<DuaEvent>((event, emit) async {
      if (event is FetchDua) {
        emit(DuaState(event.duas));
      }
      if (event is UpdateDua) {
        emit(DuaState(event.duas));
      }
    });
  }
}
