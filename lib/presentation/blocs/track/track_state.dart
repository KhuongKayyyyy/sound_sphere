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
  final List<Track> trackByArtist;
  final List<Track> featuredTracks;
  final bool isFavorite;

  const TrackDetailLoaded(
      {required this.track,
      required this.trackByArtist,
      required this.featuredTracks,
      required this.isFavorite});
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

class TrackLyricsLoaded extends TrackState {
  final String lyrics;

  const TrackLyricsLoaded(this.lyrics);
}

class TrackLyricsError extends TrackState {
  final String message;

  const TrackLyricsError(this.message);
}

class TrackLyricsLoading extends TrackState {}

class TopTrackLoaded extends TrackState {
  final List<Track> tracks;

  const TopTrackLoaded(this.tracks);
}

class TopTrackError extends TrackState {
  final String message;

  const TopTrackError(this.message);
}

class TopTrackLoading extends TrackState {}

class FeaturedTrackLoaded extends TrackState {
  final List<Track> tracks;

  const FeaturedTrackLoaded(this.tracks);
}

class FeaturedTrackError extends TrackState {
  final String message;

  const FeaturedTrackError(this.message);
}
