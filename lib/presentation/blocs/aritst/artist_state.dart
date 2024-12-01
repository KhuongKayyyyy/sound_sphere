part of 'artist_bloc.dart';

sealed class ArtistState extends Equatable {
  const ArtistState();

  @override
  List<Object> get props => [];
}

final class ArtistInitial extends ArtistState {}

class ArtistLoading extends ArtistState {}

class ArtistLoaded extends ArtistState {
  final List<Artist> artists;

  const ArtistLoaded(this.artists);
}

class ArtistError extends ArtistState {
  final String message;

  const ArtistError(this.message);
}
