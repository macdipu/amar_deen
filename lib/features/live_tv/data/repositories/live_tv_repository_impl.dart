import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:amar_deen/core/error/error_code.dart';
import 'package:amar_deen/core/error/failures.dart';
import '../../domain/entities/live_tv_channel_entity.dart';
import '../../domain/repositories/live_tv_repository.dart';
import '../datasources/live_tv_connectivity_data_source.dart';
import '../datasources/live_tv_remote_data_source.dart';

@LazySingleton(as: LiveTvRepository)
class LiveTvRepositoryImpl implements LiveTvRepository {
  final LiveTvConnectivityDataSource connectivityDataSource;
  final LiveTvRemoteDataSource remoteDataSource;

  const LiveTvRepositoryImpl(
    this.connectivityDataSource,
    this.remoteDataSource,
  );

  @override
  Future<Either<Failure, List<LiveTvChannelEntity>>> getChannels() async {
    final hasConnection = await connectivityDataSource.hasConnection();
    if (!hasConnection) {
      return Left(
        LocalFailure(
          message: kNoInternetConnection['message'],
          error: kNoInternetConnection['errorCode'] as int,
        ),
      );
    }

    try {
      final channels = await remoteDataSource.fetchChannels();
      return Right(channels);
    } catch (_) {
      return Left(
        RemoteFailure(
          message: 'Unable to load Live TV channels.',
          errorType: DioExceptionType.unknown,
        ),
      );
    }
  }
}
