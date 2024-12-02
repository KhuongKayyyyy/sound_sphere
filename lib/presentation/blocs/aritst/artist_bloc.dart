import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_sphere/core/constant/api_config.dart';
import 'package:sound_sphere/data/models/album.dart';
import 'package:sound_sphere/data/models/artist.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/data/res/album_repository.dart';
import 'package:sound_sphere/data/res/artist_repository.dart';
import 'package:sound_sphere/data/res/track_repository.dart';

part 'artist_event.dart';
part 'artist_state.dart';

class ArtistBloc extends Bloc<ArtistEvent, ArtistState> {
  ArtistBloc() : super(ArtistInitial()) {
    on<ArtistEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchArtistsEvent>(_onFetchArtistsEvent);
    on<FetchArtistNameByIdEvent>(_onFetchArtistNameEvent);
    on<FetchArtistDetailByIdEvent>(_onFetchArtistByIdEvent);
  }

  Future<void> _onFetchArtistsEvent(
      FetchArtistsEvent event, Emitter<ArtistState> emit) async {
    emit(ArtistLoading());
    try {
      final artists = await ArtistRepository.getArtists(
          event.page, event.limit, event.select);
      emit(ArtistsLoaded(artists));
    } catch (e) {
      emit(ArtistsError(e.toString()));
    }
  }

  Future<void> _onFetchArtistNameEvent(
      FetchArtistNameByIdEvent event, Emitter<ArtistState> emit) async {
    emit(ArtistNameLoading());
    try {
      final artistName = await ArtistRepository.getArtistName(event.id);
      emit(ArtistNameLoaded(artistName));
    } catch (e) {
      emit(ArtistNameError(e.toString()));
    }
  }

  Future<void> _onFetchArtistByIdEvent(
      FetchArtistDetailByIdEvent event, Emitter<ArtistState> emit) async {
    emit(ArtistByIdLoading());
    try {
      final artist = await ArtistRepository.getArtistById(event.id);
      final trackOfArtist = await TrackRepository.getTrackOfArtist(event.id);
      final topTracksOfArtist =
          await TrackRepository.getTopTrackOfArtist(event.id);
      final albumOfArtist = await AlbumRepository.getAlbumOfArtist(event.id);
      final relatedArtists = await ArtistRepository.getArtists(
          1, ApiConfig.DEFAULT_LIMIT, ArtistApi.nameAndAvatar);
      final latestAlbum =
          await AlbumRepository.getLatestAlbumByArtistId(event.id);
      emit(ArtistDetailByIdLoaded(artist, trackOfArtist, topTracksOfArtist,
          albumOfArtist, relatedArtists, latestAlbum));
    } catch (e) {
      emit(ArtistDetailByIdError(e.toString()));
    }
  }
}
