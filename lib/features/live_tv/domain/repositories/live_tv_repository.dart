import 'package:dartz/dartz.dart';

import 'package:amar_deen/core/error/failures.dart';
import '../entities/live_tv_channel_entity.dart';

/// Provides the Live TV channel list, guarded by a device connectivity check.
abstract class LiveTvRepository {
  Future<Either<Failure, List<LiveTvChannelEntity>>> getChannels();
}
