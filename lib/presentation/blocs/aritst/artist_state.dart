part of 'artist_bloc.dart';

sealed class ArtistState extends Equatable {
  const ArtistState();

  @override
  List<Object> get props => [];
}

final class ArtistInitial extends ArtistState {}

class ArtistLoading extends ArtistState {}

class ArtistsLoaded extends ArtistState {
  final List<Artist> artists;

  const ArtistsLoaded(this.artists);
}

class ArtistsError extends ArtistState {
  final String message;

  const ArtistsError(this.message);
}

class ArtistNameLoaded extends ArtistState {
  final String artistName;

  const ArtistNameLoaded(this.artistName);
}

class ArtistByIdLoaded extends ArtistState {
  final Artist artist;

  const ArtistByIdLoaded(this.artist);
}

class ArtistByIdError extends ArtistState {
  final String message;

  const ArtistByIdError(this.message);
}

class ArtistNameError extends ArtistState {
  final String message;

  const ArtistNameError(this.message);
}

class ArtistByIdLoading extends ArtistState {}

class ArtistNameLoading extends ArtistState {}
