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

class FetchArtistDetailByIdEvent extends ArtistEvent {
  final String id;

  const FetchArtistDetailByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class FetchArtistNameByIdEvent extends ArtistEvent {
  final String id;

  const FetchArtistNameByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}
