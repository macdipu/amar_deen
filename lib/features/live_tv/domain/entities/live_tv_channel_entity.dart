import 'package:equatable/equatable.dart';

/// A single Live TV channel available for playback.
class LiveTvChannelEntity extends Equatable {
  final int id;
  final String name;
  final String url;

  const LiveTvChannelEntity({
    required this.id,
    required this.name,
    required this.url,
  });

  @override
  List<Object> get props => [id, name, url];
}
