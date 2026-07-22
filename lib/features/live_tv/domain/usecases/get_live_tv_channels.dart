import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:amar_deen/core/error/failures.dart';
import '../entities/live_tv_channel_entity.dart';
import '../repositories/live_tv_repository.dart';

/// Fetches the Live TV channel list.
@injectable
class GetLiveTvChannels {
  final LiveTvRepository repository;

  const GetLiveTvChannels(this.repository);

  Future<Either<Failure, List<LiveTvChannelEntity>>> call() =>
      repository.getChannels();
}
