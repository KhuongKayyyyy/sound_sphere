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
