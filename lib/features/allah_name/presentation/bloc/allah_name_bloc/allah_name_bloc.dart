import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:amar_deen/core/di/injection.dart';
import '../../../domain/entities/name_of_allah_entity.dart';
import '../../../domain/usecases/get_allah_names.dart';

part 'allah_name_event.dart';
part 'allah_name_state.dart';

class AllahNameBloc extends Bloc<AllahNameEvent, AllahNameState> {
  final GetAllahNames getAllahNames;

  AllahNameBloc({GetAllahNames? getAllahNames})
      : getAllahNames = getAllahNames ?? getIt<GetAllahNames>(),
        super(const AllahNameState([])) {
    on<AllahNameEvent>((event, emit) async {
      if (event is FetchAllahName) {
        final names = await this.getAllahNames();
        emit(AllahNameState(names));
      }
    });
  }
}
