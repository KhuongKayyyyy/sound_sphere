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

class ArtistDetailByIdLoaded extends ArtistState {
  final Artist artist;
  final List<Track> trackOfArtist;
  final List<Album> albumOfArtist;
  final List<Artist> relatedArtists;
  const ArtistDetailByIdLoaded(
      this.artist, this.trackOfArtist, this.albumOfArtist, this.relatedArtists);
}

class ArtistDetailByIdError extends ArtistState {
  final String message;

  const ArtistDetailByIdError(this.message);
}

class ArtistNameError extends ArtistState {
  final String message;

  const ArtistNameError(this.message);
}

class ArtistByIdLoading extends ArtistState {}

class ArtistNameLoading extends ArtistState {}
