part of 'track_bloc.dart';

sealed class TrackState extends Equatable {
  const TrackState();

  @override
  List<Object> get props => [];
}

final class TrackInitial extends TrackState {}

class TrackLoading extends TrackState {}

class TrackLoaded extends TrackState {
  final List<Track> tracks;

  const TrackLoaded(this.tracks);
}

class TrackError extends TrackState {
  final String message;

  const TrackError(this.message);
}
