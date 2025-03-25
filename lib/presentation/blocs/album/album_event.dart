part of 'album_bloc.dart';

sealed class AlbumEvent extends Equatable {
  const AlbumEvent();

  @override
  List<Object> get props => [];
}

class FetchAlbumsPreviewEvent extends AlbumEvent {
  final int page;
  final int limit;

  const FetchAlbumsPreviewEvent(this.page, this.limit);

  @override
  List<Object> get props => [page, limit];
}

class FetchAlbumDetailEvent extends AlbumEvent {
  final String albumId;

  const FetchAlbumDetailEvent(this.albumId);

  @override
  List<Object> get props => [albumId];
}
