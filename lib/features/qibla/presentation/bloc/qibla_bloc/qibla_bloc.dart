import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/di/injection.dart';
import 'package:amar_deen/core/error/failures.dart';
import 'package:amar_deen/core/bloc/location/location_bloc.dart';
import '../../../domain/entities/qiblah_direction_entity.dart';
import '../../../domain/usecases/watch_qiblah_direction.dart';

part 'qibla_event.dart';
part 'qibla_state.dart';

class QiblaBloc extends Bloc<QiblaEvent, QiblaState> {
  final WatchQiblahDirection watchQiblahDirection;

  QiblaBloc({WatchQiblahDirection? watchQiblahDirection})
      : watchQiblahDirection =
            watchQiblahDirection ?? getIt<WatchQiblahDirection>(),
        super(QiblaInitial()) {
    on<QiblaEvent>((event, emit) async {
      if (event is RequestQiblahDirection) {
        if (event.locationState is LocationFailed) {
          emit(QiblaFailed(event.locationState.failure!));
          return;
        }

        emit(QiblaLoading());

        await emit.forEach<QiblahDirectionEntity>(
          this.watchQiblahDirection(),
          onData: (direction) => QiblaLoaded(
            direction: direction.qiblahBearing,
            heading: direction.heading,
          ),
          onError: (error, stackTrace) => QiblaFailed(
            LocalFailure(message: error.toString(), error: 0),
          ),
        );
      }
    });
  }
}
