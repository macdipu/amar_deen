import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../src/core/error/failures.dart';
import '../../../../../src/core/util/bloc/location/location_bloc.dart';
import '../../../../prayer_times/domain/entities/prayer_calculation_method.dart';
import '../../../domain/entities/ramadan_times_entity.dart';
import '../../../domain/usecases/get_ramadan_times.dart';

part 'ramadan_event.dart';
part 'ramadan_state.dart';

class RamadanBloc extends Bloc<RamadanEvent, RamadanState> {
  final GetRamadanTimes _getRamadanTimes;

  RamadanBloc({GetRamadanTimes? getRamadanTimes})
      : _getRamadanTimes = getRamadanTimes ?? getIt<GetRamadanTimes>(),
        super(RamadanInitial()) {
    on<RequestRamadanTimes>((event, emit) async {
      if (!(event.locationState is LocationSuccess)) {
        emit(RamadanFailed(event.locationState.failure!));
        return;
      }

      emit(RamadanLoading());

      try {
        final baseDate = DateTime.now().add(Duration(days: event.dayOffset));
        final date = DateTime(baseDate.year, baseDate.month, baseDate.day);

        final ramadanTimes = _getRamadanTimes(
          latitude: event.locationState.latitude,
          longitude: event.locationState.longitude,
          date: date,
          method: event.method,
          madhab: event.madhab,
        );

        emit(RamadanLoaded(ramadanTimes));
      } catch (e) {
        emit(RamadanFailed(LocalFailure(message: e.toString(), error: 0)));
      }
    });
  }
}
