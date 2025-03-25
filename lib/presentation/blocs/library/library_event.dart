part of 'library_bloc.dart';

sealed class LibraryEvent extends Equatable {
  const LibraryEvent();

  @override
  List<Object> get props => [];
}

class GetTrackLibraryRequest extends LibraryEvent {}

class CheckIfTrackIsFavorite extends LibraryEvent {
  final String trackId;

  const CheckIfTrackIsFavorite(this.trackId);

  @override
  List<Object> get props => [trackId];
}

class ToggleTrackFavorite extends LibraryEvent {
  final Track track;
  final bool isFavorite;

  const ToggleTrackFavorite({required this.track, required this.isFavorite});

  @override
  List<Object> get props => [track, isFavorite];
}

class AddTrackToFavorites extends LibraryEvent {
  final String trackId;

  const AddTrackToFavorites({required this.trackId});

  @override
  List<Object> get props => [trackId];
}

class RemoveTrackFromLibRequest extends LibraryEvent {
  final String trackId;

  const RemoveTrackFromLibRequest(this.trackId);

  @override
  List<Object> get props => [trackId];
}

class AddTrackToLibraryRequest extends LibraryEvent {
  final String trackId;

  const AddTrackToLibraryRequest(this.trackId);

  @override
  List<Object> get props => [trackId];
}

class GetFavoriteTracksRequest extends LibraryEvent {}
