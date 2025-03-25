import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_sphere/core/constant/api_config.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/data/res/library_repository.dart';
import 'package:sound_sphere/data/res/track_repository.dart';

part 'track_event.dart';
part 'track_state.dart';

class TrackBloc extends Bloc<TrackEvent, TrackState> {
  final LibraryRepository _libraryRepository = LibraryRepository();
  TrackBloc() : super(TrackInitial()) {
    on<TrackEvent>((event, emit) {});
    on<FetchTracksEvent>(_onFetchTracksEvent);
    on<FetchTrackDetail>(_onFetchTrackDetailByIdEvent);
    on<FetchTracksByArtistEvent>(_onFetchTracksByArtistEvent);
    on<FetchTrackLyrics>(_onFetchTrackLyrics);
    on<FetchTopTrack>(_onFetchTopTrack);
    on<FetchFeaturedTrack>(_onFetchFeaturedTrack);
  }

  Future<void> _onFetchFeaturedTrack(
      FetchFeaturedTrack event, Emitter<TrackState> emit) async {
    emit(TracksLoading());
    try {
      final tracks =
          await TrackRepository.getFeaturedTrack(artistId: event.artistId);
      emit(TracksLoaded(tracks));
    } catch (e) {
      emit(TracksError(e.toString()));
    }
  }

  Future<void> _onFetchTracksEvent(
      FetchTracksEvent event, Emitter<TrackState> emit) async {
    emit(TracksLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      final tracks = await TrackRepository.getTracksWithPreview(
          event.page, event.limit, event.select);
      emit(TracksLoaded(tracks));
    } catch (e) {
      emit(TracksError(e.toString()));
    }
  }

  Future<void> _onFetchTrackDetailByIdEvent(
      FetchTrackDetail event, Emitter<TrackState> emit) async {
    emit(TrackDetailLoading());
    try {
      final track = await TrackRepository.getTrackDetailById(
          event.track.id!, TrackApi.fullTrack);
      final trackByArtist =
          await TrackRepository.getTracksOfArtist(track.artist.id!);
      final featuredTrack = await TrackRepository.getFeaturedTrack(
          artistId: event.track.artist.id!);
      final isFavorite = await _libraryRepository.isTrackFavorite(
        trackId: track.id!,
      );
      emit(TrackDetailLoaded(
          track: track,
          trackByArtist: trackByArtist,
          featuredTracks: featuredTrack,
          isFavorite: isFavorite));
    } catch (e) {
      emit(TrackDetailError(e.toString()));
    }
  }

  Future<void> _onFetchTracksByArtistEvent(
      FetchTracksByArtistEvent event, Emitter<TrackState> emit) async {
    emit(TrackByArtistLoading());
    try {
      final tracks = await TrackRepository.getTracksOfArtist(event.artistId);
      emit(TrackByArtistLoaded(tracks));
    } catch (e) {
      emit(TrackByArtistError(e.toString()));
    }
  }

  Future<void> _onFetchTrackLyrics(
      FetchTrackLyrics event, Emitter<TrackState> emit) async {
    emit(TrackDetailLoading());
    try {
      final lyrics = await TrackRepository.getTrackLyric(event.id);
      emit(TrackLyricsLoaded(lyrics));
    } catch (e) {
      emit(TrackDetailError(e.toString()));
    }
  }

  Future<void> _onFetchTopTrack(
      FetchTopTrack event, Emitter<TrackState> emit) async {
    emit(TopTrackLoading());
    try {
      final tracks = await TrackRepository.getTopTrackByPlay();
      emit(TopTrackLoaded(tracks));
    } catch (e) {
      emit(TopTrackError(e.toString()));
    }
  }
}
