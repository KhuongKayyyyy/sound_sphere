part of 'playlist_bloc.dart';

sealed class PlaylistEvent extends Equatable {
  const PlaylistEvent();

  @override
  List<Object> get props => [];
}

class PlaylistGetListRequested extends PlaylistEvent {
  const PlaylistGetListRequested();
}

class PLGetDetailRequested extends PlaylistEvent {
  final Playlist playlist;

  const PLGetDetailRequested(this.playlist);

  @override
  List<Object> get props => [playlist];
}

class PLAddNewRequested extends PlaylistEvent {
  final String playlistName;

  const PLAddNewRequested({required this.playlistName});

  @override
  List<Object> get props => [playlistName];
}

class PLAddTrackRequested extends PlaylistEvent {
  final String playlistId;
  final String trackId;

  const PLAddTrackRequested({required this.playlistId, required this.trackId});

  @override
  List<Object> get props => [playlistId, trackId];
}

class PLRemoveTrackRequested extends PlaylistEvent {
  final String playlistId;
  final String trackId;

  const PLRemoveTrackRequested(
      {required this.playlistId, required this.trackId});

  @override
  List<Object> get props => [playlistId, trackId];
}

class PLChangeStateRequested extends PlaylistEvent {
  final List<Playlist> playlists;

  const PLChangeStateRequested(this.playlists);

  @override
  List<Object> get props => [playlists];
}

class PLAddAlbumToPlaylistRequested extends PlaylistEvent {
  final String playlistId;
  final String albumId;

  const PLAddAlbumToPlaylistRequested(
      {required this.playlistId, required this.albumId});

  @override
  List<Object> get props => [playlistId, albumId];
}

class PLDeleteRequested extends PlaylistEvent {
  final String playlistId;

  const PLDeleteRequested({required this.playlistId});

  @override
  List<Object> get props => [playlistId];
}
