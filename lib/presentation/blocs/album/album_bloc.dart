import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_sphere/data/models/album.dart';
import 'package:sound_sphere/data/res/album_repository.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  AlbumBloc() : super(AlbumInitial()) {
    on<AlbumEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchAlbumsPreviewEvent>(_onFetchAlbumsPreviewEvent);
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
}
