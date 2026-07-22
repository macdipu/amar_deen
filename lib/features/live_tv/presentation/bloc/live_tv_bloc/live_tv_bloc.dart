import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:amar_deen/core/di/injection.dart';
import 'package:amar_deen/core/error/failures.dart';
import '../../../domain/entities/live_tv_channel_entity.dart';
import '../../../domain/usecases/get_live_tv_channels.dart';

part 'live_tv_event.dart';
part 'live_tv_state.dart';

class LiveTvBloc extends Bloc<LiveTvEvent, LiveTvState> {
  final GetLiveTvChannels getLiveTvChannels;

  LiveTvBloc({GetLiveTvChannels? getLiveTvChannels})
      : getLiveTvChannels = getLiveTvChannels ?? getIt<GetLiveTvChannels>(),
        super(const LiveTvState.initial()) {
    on<LiveTvEvent>((event, emit) async {
      if (event is FetchLiveTvChannels) {
        emit(const LiveTvState.loading());

        final result = await this.getLiveTvChannels();
        result.fold(
          (failure) => emit(LiveTvState.failed(failure)),
          (channels) => emit(LiveTvState.loaded(channels)),
        );
      }
    });
  }
}
