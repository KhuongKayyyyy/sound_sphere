part of 'album_bloc.dart';

sealed class AlbumEvent extends Equatable {
  const AlbumEvent();

  @override
  List<Object> get props => [];
}

class FetchAlbumsPreviewEvent extends AlbumEvent {
  final int page;

  const FetchAlbumsPreviewEvent(this.page);

  @override
  List<Object> get props => [page];
}

class FetchAlbumDetailEvent extends AlbumEvent {
  final String albumId;

  const FetchAlbumDetailEvent(this.albumId);

  @override
  List<Object> get props => [albumId];
}
