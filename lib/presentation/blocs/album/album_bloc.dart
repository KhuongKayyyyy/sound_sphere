import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_sphere/data/models/album.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/data/res/album_repository.dart';
import 'package:sound_sphere/data/res/track_repository.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  AlbumBloc() : super(AlbumInitial()) {
    on<AlbumEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchAlbumsPreviewEvent>(_onFetchAlbumsPreviewEvent);
    on<FetchAlbumDetailEvent>(_onFetchAlbumDetailEvent);
  }

  Future<void> _onFetchAlbumsPreviewEvent(
      FetchAlbumsPreviewEvent event, Emitter<AlbumState> emit) async {
    emit(AlbumPreviewLoading());
    try {
      final albums =
          await AlbumRepository.fetchAlbumWithPreviewInformation(event.page);
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
      album.tracks = await TrackRepository.getTrackOfAlbum(event.albumId);
      // final tracks = await TrackRepository.getTrackOfAlbum(event.albumId);
      emit(AlbumDetailLoaded(album));
    } catch (e) {
      emit(AlbumDetailError(e.toString()));
    }
  }
}
