part of 'playlist_bloc.dart';

sealed class PlaylistState extends Equatable {
  const PlaylistState();

  @override
  List<Object> get props => [];
}

final class PlaylistInitial extends PlaylistState {}

class PlaylistLoading extends PlaylistState {}

class PlaylistGetSuccess extends PlaylistState {
  final List<UserPlaylist> playlists;

  const PlaylistGetSuccess(this.playlists);

  @override
  List<Object> get props => [playlists];
}

class PlaylistGetFailure extends PlaylistState {
  final String message;

  const PlaylistGetFailure(this.message);

  @override
  List<Object> get props => [message];
}

class PLGetDetailSuccess extends PlaylistState {
  final List<Track> playlist;
  final List<Artist> artists;
  const PLGetDetailSuccess(this.playlist, this.artists);

  @override
  List<Object> get props => [playlist, artists];
}

class PLGetDetailFailure extends PlaylistState {
  final String message;

  const PLGetDetailFailure(this.message);

  @override
  List<Object> get props => [message];
}

class PLAddNewLoading extends PlaylistState {}

class PLAddNewSuccess extends PlaylistState {
  final UserPlaylist playlist;

  const PLAddNewSuccess(this.playlist);

  @override
  List<Object> get props => [playlist];
}

class PLAddNewFailure extends PlaylistState {
  final String message;

  const PLAddNewFailure(this.message);

  @override
  List<Object> get props => [message];
}

class PLAddTrackLoading extends PlaylistState {}

class PLAddTrackSuccess extends PlaylistState {
  final UserPlaylist playlist;

  const PLAddTrackSuccess(this.playlist);

  @override
  List<Object> get props => [playlist];
}

class PLAddTrackFailure extends PlaylistState {
  final String message;

  const PLAddTrackFailure(this.message);

  @override
  List<Object> get props => [message];
}

class PLRemoveTrackLoading extends PlaylistState {}

class PLRemoveTrackSuccess extends PlaylistState {
  final UserPlaylist playlist;

  const PLRemoveTrackSuccess(this.playlist);

  @override
  List<Object> get props => [playlist];
}

class PLRemoveTrackFailure extends PlaylistState {
  final String message;

  const PLRemoveTrackFailure(this.message);

  @override
  List<Object> get props => [message];
}

class PLChangeStateSuccess extends PlaylistState {
  final List<UserPlaylist> playlists;

  const PLChangeStateSuccess(this.playlists);

  @override
  List<Object> get props => [playlists];
}

class PLChangeStateFailure extends PlaylistState {
  final String message;

  const PLChangeStateFailure(this.message);

  @override
  List<Object> get props => [message];
}

class PLChangeStateLoading extends PlaylistState {}

class PLDeleteSuccess extends PlaylistState {
  final UserPlaylist playlist;

  const PLDeleteSuccess(this.playlist);

  @override
  List<Object> get props => [playlist];
}

class PLDeleteFailure extends PlaylistState {
  final String message;

  const PLDeleteFailure(this.message);

  @override
  List<Object> get props => [message];
}

class PLDeleteLoading extends PlaylistState {}
