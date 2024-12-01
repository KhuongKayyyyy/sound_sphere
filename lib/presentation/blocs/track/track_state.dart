part of 'track_bloc.dart';

sealed class TrackState extends Equatable {
  const TrackState();

  @override
  List<Object> get props => [];
}

final class TrackInitial extends TrackState {}

class TracksLoading extends TrackState {}

class TracksLoaded extends TrackState {
  final List<Track> tracks;

  const TracksLoaded(this.tracks);
}

class TracksError extends TrackState {
  final String message;

  const TracksError(this.message);
}

class TrackDetailLoaded extends TrackState {
  final Track track;
  final String artistName;
  final List<Track> trackByArtist;

  const TrackDetailLoaded(this.track, this.artistName, this.trackByArtist);
}

class TrackDetailError extends TrackState {
  final String message;

  const TrackDetailError(this.message);
}

class TrackDetailLoading extends TrackState {}

class TrackByArtistLoaded extends TrackState {
  final List<Track> tracks;

  const TrackByArtistLoaded(this.tracks);
}

class TrackByArtistError extends TrackState {
  final String message;

  const TrackByArtistError(this.message);
}

class TrackByArtistLoading extends TrackState {}
