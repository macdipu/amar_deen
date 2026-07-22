import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/di/injection.dart';
import '../../../domain/entities/prayer_calculation_method.dart';
import '../../../domain/entities/prayer_times_entity.dart';
import '../../../domain/usecases/get_prayer_times.dart';
import 'package:amar_deen/core/error/failures.dart';
import 'package:amar_deen/core/bloc/location/location_bloc.dart';

part 'timing_event.dart';
part 'timing_state.dart';

class TimingBloc extends Bloc<TimingEvent, TimingState> {
  final GetPrayerTimes _getPrayerTimes;

  /// storage for data to prevent unnecessary recomputation
  PrayerTimesEntity? _prayerTimes;

  /// constructor
  TimingBloc({GetPrayerTimes? getPrayerTimes})
      : _getPrayerTimes = getPrayerTimes ?? getIt<GetPrayerTimes>(),
        super(TimingInitial()) {
    on<TimingEvent>((event, emit) async {
      if (event is RequestTiming) {
        emit(TimingLoading());

        if (event.locationState is LocationFailed) {
          emit(TimingFailed(event.locationState.failure!));
          return;
        }

        if (event.locationState is! LocationSuccess) {
          /// location still resolving (Loading/Initial) - `failure` is null
          /// here, so stay in TimingLoading instead of force-unwrapping it.
          /// A later RequestTiming once location resolves moves this
          /// forward.
          return;
        }

        try {
          final baseDate = DateTime.now().add(
            Duration(days: event.dayOffset),
          );
          final date = DateTime(baseDate.year, baseDate.month, baseDate.day);

          final prayerTimes = _getPrayerTimes(
            latitude: event.locationState.latitude,
            longitude: event.locationState.longitude,
            date: date,
            method: event.method,
            madhab: event.madhab,
          );

          _prayerTimes = prayerTimes;
          emit(TimingLoaded(prayerTimes));
        } catch (e) {
          emit(TimingFailed(LocalFailure(message: e.toString(), error: 0)));
        }
      }

      /// if data is not yet outdated, we just re-emit the cached
      /// prayer times computed earlier
      else if (event is UpdateTiming) {
        if (_prayerTimes != null) {
          emit(TimingLoaded(_prayerTimes!));
        }
      }
    });
  }
}
