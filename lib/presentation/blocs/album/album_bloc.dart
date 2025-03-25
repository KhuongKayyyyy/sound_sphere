import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_sphere/data/models/album.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/data/models/track_in_library.dart';
import 'package:sound_sphere/data/res/album_repository.dart';
import 'package:sound_sphere/data/res/library_repository.dart';
import 'package:sound_sphere/data/res/track_repository.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  AlbumBloc() : super(AlbumInitial()) {
    on<AlbumEvent>((event, emit) {});
    on<FetchAlbumsPreviewEvent>(_onFetchAlbumsPreviewEvent);
    on<FetchAlbumDetailEvent>(_onFetchAlbumDetailEvent);
  }

  Future<void> _onFetchAlbumsPreviewEvent(
      FetchAlbumsPreviewEvent event, Emitter<AlbumState> emit) async {
    emit(AlbumPreviewLoading());
    try {
      final albums = await AlbumRepository.fetchAlbumWithPreviewInformation(
          event.page, event.limit);
      emit(AlbumPreviewLoaded(albums));
    } catch (e) {
      emit(AlbumPreviewError(e.toString()));
    }
  }

  Future<void> _onFetchAlbumDetailEvent(
      FetchAlbumDetailEvent event, Emitter<AlbumState> emit) async {
    emit(AlbumDetailLoading());
    try {
      final album = await AlbumRepository.getAlbumDetailById(event.albumId);
      album.tracks = await TrackRepository.getTracksOfAlbum(event.albumId);
      final topTrackOfArtist = await TrackRepository.getTopTracksOfArtist(
          artistId: album.aritst.id!, page: 1, limit: 10);
      final featuredTracks =
          await TrackRepository.getFeaturedTrack(artistId: album.aritst.id!);
      final favoriteTracks = await LibraryRepository().getFavoriteTracks();
      emit(AlbumDetailLoaded(
          album: album,
          topTrackOfArtist: topTrackOfArtist,
          featuredTracks: featuredTracks,
          favoriteTracks: favoriteTracks));
    } catch (e) {
      emit(AlbumDetailError(e.toString()));
    }
  }
}
