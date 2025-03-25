part of 'library_bloc.dart';

sealed class LibraryState extends Equatable {
  const LibraryState();

  @override
  List<Object> get props => [];
}

final class LibraryInitial extends LibraryState {}

final class LibraryLoading extends LibraryState {}

final class TrackLibraryLoaded extends LibraryState {
  final List<Track> tracks;
  final List<TrackInLibrary> favoriteTracks;

  const TrackLibraryLoaded({
    required this.tracks,
    required this.favoriteTracks,
  });

  @override
  List<Object> get props => [tracks];
}

final class TrackLibraryError extends LibraryState {
  final String message;

  const TrackLibraryError(this.message);

  @override
  List<Object> get props => [message];
}

class CheckIfTrackIsFavoritLoading extends LibraryState {}

class CheckTrackFavoriteSuccess extends LibraryState {
  final bool isFavorite;

  const CheckTrackFavoriteSuccess(this.isFavorite);

  @override
  List<Object> get props => [isFavorite];
}

class CheckTrackFavoriteError extends LibraryState {
  final String message;

  const CheckTrackFavoriteError(this.message);

  @override
  List<Object> get props => [message];
}

class ToggleTrackFavoriteLoading extends LibraryState {}

class ToggleTrackFavoriteSuccess extends LibraryState {
  final bool isFavorite;

  const ToggleTrackFavoriteSuccess(this.isFavorite);

  @override
  List<Object> get props => [isFavorite];
}

class ToggleTrackFavoriteError extends LibraryState {
  final String message;

  const ToggleTrackFavoriteError(this.message);

  @override
  List<Object> get props => [message];
}

class AddTrackToFavoritesSuccess extends LibraryState {}

class AddTrackToFavoritesError extends LibraryState {
  final String message;

  const AddTrackToFavoritesError(this.message);

  @override
  List<Object> get props => [message];
}

class AddTrackToFavoritesLoading extends LibraryState {}

class RemoveTrackFromLibRequestLoading extends LibraryState {}

class RemoveTrackFromLibSuccess extends LibraryState {}

class RemoveTrackFromLibError extends LibraryState {
  final String message;

  const RemoveTrackFromLibError(this.message);

  @override
  List<Object> get props => [message];
}

class AddTrackToLibraryRequestLoading extends LibraryState {}

class AddTrackToLibrarySuccess extends LibraryState {}

class AddTrackToLibraryError extends LibraryState {
  final String message;

  const AddTrackToLibraryError(this.message);

  @override
  List<Object> get props => [message];
}

class GetFavoriteTracksRequestLoading extends LibraryState {}

class GetFavoriteTracksRequestSuccess extends LibraryState {
  final List<Track> tracks;
  final List<TrackInLibrary> favoriteTracks;

  const GetFavoriteTracksRequestSuccess(
      {required this.favoriteTracks, required this.tracks});

  @override
  List<Object> get props => [favoriteTracks];
}

class GetFavoriteTracksRequestError extends LibraryState {
  final String message;

  const GetFavoriteTracksRequestError(this.message);

  @override
  List<Object> get props => [message];
}
