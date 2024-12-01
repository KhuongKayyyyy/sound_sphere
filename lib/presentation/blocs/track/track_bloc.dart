import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/data/res/artist_repository.dart';
import 'package:sound_sphere/data/res/track_repository.dart';

part 'track_event.dart';
part 'track_state.dart';

class TrackBloc extends Bloc<TrackEvent, TrackState> {
  TrackBloc() : super(TrackInitial()) {
    on<TrackEvent>((event, emit) {});
    on<FetchTracksEvent>(_onFetchTracksEvent);
    on<FetchTrackDetail>(_onFetchTrackByIdEvent);
    on<FetchTracksByArtistEvent>(_onFetchTracksByArtistEvent);
  }

  Future<void> _onFetchTracksEvent(
      FetchTracksEvent event, Emitter<TrackState> emit) async {
    emit(TracksLoading());
    try {
      final tracks = await TrackRepository.getTrackWithPreview(
          event.page, event.limit, event.select);
      emit(TracksLoaded(tracks));
    } catch (e) {
      emit(TracksError(e.toString()));
    }
  }

  Future<void> _onFetchTrackByIdEvent(
      FetchTrackDetail event, Emitter<TrackState> emit) async {
    emit(TrackDetailLoading());
    try {
      final track = await TrackRepository.getTrackById(event.id);
      final artistName = await ArtistRepository.getArtistName(track.artist);
      final trackByArtist =
          await TrackRepository.getTrackOfArtist(track.artist);
      emit(TrackDetailLoaded(track, artistName, trackByArtist));
    } catch (e) {
      emit(TrackDetailError(e.toString()));
    }
  }

  Future<void> _onFetchTracksByArtistEvent(
      FetchTracksByArtistEvent event, Emitter<TrackState> emit) async {
    emit(TrackByArtistLoading());
    try {
      final tracks = await TrackRepository.getTrackOfArtist(event.artistId);
      emit(TrackByArtistLoaded(tracks));
    } catch (e) {
      emit(TrackByArtistError(e.toString()));
    }
  }
}
