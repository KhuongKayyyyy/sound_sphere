part of 'artist_bloc.dart';

abstract class ArtistEvent extends Equatable {
  const ArtistEvent();

  @override
  List<Object?> get props => [];
}

class FetchArtistsEvent extends ArtistEvent {
  final int page;
  final int limit;
  final String select;

  const FetchArtistsEvent(this.page, this.limit, this.select);

  @override
  List<Object?> get props => [page, limit, select];
}

class FetchArtistByIdEvent extends ArtistEvent {
  final String id;

  const FetchArtistByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class FetchArtistNameEvent extends ArtistEvent {
  final String id;

  const FetchArtistNameEvent(this.id);

  @override
  List<Object?> get props => [id];
}
