import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_sphere/data/models/artist.dart';
import 'package:sound_sphere/data/res/artist_repository.dart';

part 'artist_event.dart';
part 'artist_state.dart';

class ArtistBloc extends Bloc<ArtistEvent, ArtistState> {
  ArtistBloc() : super(ArtistInitial()) {
    on<ArtistEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchArtistsEvent>(_onFetchArtistsEvent);
  }

  Future<void> _onFetchArtistsEvent(
      FetchArtistsEvent event, Emitter<ArtistState> emit) async {
    emit(ArtistLoading());
    try {
      final artists = await ArtistRepository.fetchArtists(
          event.page, event.limit, event.select);
      emit(ArtistLoaded(artists));
    } catch (e) {
      emit(ArtistError(e.toString()));
    }
  }
}
