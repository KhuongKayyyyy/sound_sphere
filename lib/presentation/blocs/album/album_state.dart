part of 'album_bloc.dart';

sealed class AlbumState extends Equatable {
  const AlbumState();

  @override
  List<Object> get props => [];
}

final class AlbumInitial extends AlbumState {}

final class AlbumPreviewLoading extends AlbumState {}

final class AlbumPreviewError extends AlbumState {
  final String message;

  const AlbumPreviewError(this.message);

  @override
  List<Object> get props => [message];
}

final class AlbumPreviewLoaded extends AlbumState {
  final List<Album> albums;

  const AlbumPreviewLoaded(this.albums);

  @override
  List<Object> get props => [albums];
}
