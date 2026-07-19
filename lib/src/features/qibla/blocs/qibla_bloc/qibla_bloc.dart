import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/util/bloc/location/location_bloc.dart';

part 'qibla_event.dart';
part 'qibla_state.dart';

class QiblaBloc extends Bloc<QiblaEvent, QiblaState> {
  QiblaBloc() : super(QiblaInitial()) {
    on<QiblaEvent>((event, emit) async {
      if (event is RequestQiblahDirection) {
        if (event.locationState is LocationFailed) {
          emit(QiblaFailed(event.locationState.failure!));
          return;
        }

        emit(QiblaLoading());

        // flutter_qiblah handles location + sensor fusion + bearing math
        // internally; each tick carries both the fixed Qiblah bearing and
        // the device's live compass heading.
        await emit.forEach<QiblahDirection>(
          FlutterQiblah.qiblahStream,
          onData: (direction) => QiblaLoaded(
            direction: direction.qiblah,
            heading: direction.direction,
          ),
          onError: (error, stackTrace) => QiblaFailed(
            LocalFailure(message: error.toString(), error: 0),
          ),
        );
      }
    });
  }
}
