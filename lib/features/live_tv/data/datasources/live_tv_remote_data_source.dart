import 'package:injectable/injectable.dart';

import 'package:amar_deen/core/network/network_client.dart';
import '../../domain/entities/live_tv_channel_entity.dart';

/// Fetches the Live TV channel list from the mp3quran.net API.
abstract class LiveTvRemoteDataSource {
  Future<List<LiveTvChannelEntity>> fetchChannels();
}

@LazySingleton(as: LiveTvRemoteDataSource)
class LiveTvRemoteDataSourceImpl implements LiveTvRemoteDataSource {
  const LiveTvRemoteDataSourceImpl();

  @override
  Future<List<LiveTvChannelEntity>> fetchChannels() async {
    final client = NetworkClient('https://www.mp3quran.net');
    final resp = await client.get('/api/v3/live-tv', {});

    final data = resp.data;
    final rawList = (data is Map && data['livetv'] is List)
        ? (data['livetv'] as List)
        : const [];

    return rawList
        .whereType<Map>()
        .map((e) => _channelFromJson(e.cast<String, dynamic>()))
        .where((c) => c.url.isNotEmpty)
        .toList(growable: false);
  }

  LiveTvChannelEntity _channelFromJson(Map<String, dynamic> json) {
    return LiveTvChannelEntity(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      url: json['url']?.toString() ?? '',
    );
  }
}
