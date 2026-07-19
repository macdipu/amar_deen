import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../src/core/error/failures.dart';
import '../../../../../src/core/util/bloc/location/location_bloc.dart';
import '../../../domain/entities/prayer_calculation_method.dart';
import '../../../domain/entities/voluntary_prayer_times_entity.dart';
import '../../../domain/usecases/get_voluntary_prayer_times.dart';

part 'voluntary_prayer_event.dart';
part 'voluntary_prayer_state.dart';

class VoluntaryPrayerBloc
    extends Bloc<VoluntaryPrayerEvent, VoluntaryPrayerState> {
  final GetVoluntaryPrayerTimes _getVoluntaryPrayerTimes;

  VoluntaryPrayerBloc({GetVoluntaryPrayerTimes? getVoluntaryPrayerTimes})
      : _getVoluntaryPrayerTimes =
            getVoluntaryPrayerTimes ?? getIt<GetVoluntaryPrayerTimes>(),
        super(VoluntaryPrayerInitial()) {
    on<RequestVoluntaryPrayerTimes>((event, emit) async {
      if (!(event.locationState is LocationSuccess)) {
        emit(VoluntaryPrayerFailed(event.locationState.failure!));
        return;
      }

      emit(VoluntaryPrayerLoading());

      try {
        final baseDate = DateTime.now().add(Duration(days: event.dayOffset));
        final date = DateTime(baseDate.year, baseDate.month, baseDate.day);

        final voluntaryPrayerTimes = _getVoluntaryPrayerTimes(
          latitude: event.locationState.latitude,
          longitude: event.locationState.longitude,
          date: date,
          method: event.method,
          madhab: event.madhab,
        );

        emit(VoluntaryPrayerLoaded(voluntaryPrayerTimes));
      } catch (e) {
        emit(VoluntaryPrayerFailed(LocalFailure(message: e.toString(), error: 0)));
      }
    });
  }
}
