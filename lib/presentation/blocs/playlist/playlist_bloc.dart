import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_sphere/core/utils/helpers.dart';
import 'package:sound_sphere/data/models/artist.dart';
import 'package:sound_sphere/data/models/playlist.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/data/res/playlist_repository.dart';
import 'package:sound_sphere/data/res/track_repository.dart';

part 'playlist_event.dart';
part 'playlist_state.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  final PlaylistRepository _playlistRepository = PlaylistRepository();
  PlaylistBloc() : super(PlaylistInitial()) {
    on<PlaylistEvent>((event, emit) {});

    on<PlaylistGetListRequested>(_onPlaylistGetListRequested);
    on<PLGetDetailRequested>(_onPlaylistDetailRequested);
    on<PLAddNewRequested>(_onPlaylistAddNewRequested);
    on<PLAddTrackRequested>(_onPlaylistAddTrackRequested);
    on<PLRemoveTrackRequested>(_onPlaylistRemoveTrackRequested);
  }

  void _onPlaylistRemoveTrackRequested(
      PLRemoveTrackRequested event, Emitter<PlaylistState> emit) async {
    emit(PLRemoveTrackLoading());
    try {
      final playlist = await _playlistRepository.removeTrackToPlaylist(
          playlistId: event.playlistId, trackId: event.trackId);
      emit(PLRemoveTrackSuccess(playlist));
    } catch (e) {
      emit(PLRemoveTrackFailure(e.toString()));
    }
  }

  void _onPlaylistAddTrackRequested(
      PLAddTrackRequested event, Emitter<PlaylistState> emit) async {
    emit(PLAddTrackLoading());
    try {
      final playlist = await _playlistRepository.addTrackToPlaylist(
          playlistId: event.playlistId, trackId: event.trackId);
      emit(PLAddTrackSuccess(playlist));
    } catch (e) {
      emit(PLAddTrackFailure(e.toString()));
    }
  }

  void _onPlaylistAddNewRequested(
      PLAddNewRequested event, Emitter<PlaylistState> emit) async {
    emit(PLAddNewLoading());
    try {
      final Playlist playlist = await _playlistRepository.createNewPlaylist(
          playlistName: event.playlistName);
      emit(PLAddNewSuccess(playlist));
    } catch (e) {
      emit(PLAddNewFailure(e.toString()));
    }
  }

  void _onPlaylistGetListRequested(
      PlaylistGetListRequested event, Emitter<PlaylistState> emit) async {
    emit(PlaylistLoading()); // Shows loading
    try {
      final List<Playlist> playlists =
          await _playlistRepository.getPlaylistOfUser();

      if (playlists.isNotEmpty) {
        emit(PlaylistGetSuccess(playlists));
      } else {
        emit(PlaylistGetFailure("No playlists found"));
      }
    } catch (e) {
      emit(PlaylistGetFailure(e.toString()));
    }
  }

  void _onPlaylistDetailRequested(
      PLGetDetailRequested event, Emitter<PlaylistState> emit) async {
    emit(PlaylistLoading());
    try {
      final newPlaylist = await _playlistRepository.getPlaylistById(
          playlistId: event.playlist.id!);
      List<Track> tracks = [];
      for (var track in newPlaylist.tracks!) {
        tracks.add(await TrackRepository.getTrackDetailById(track.id));
      }
      List<Artist> artists = Helpers.getArtistsFromTracks(tracks);
      emit(PLGetDetailSuccess(tracks, artists));
    } catch (e) {
      emit(PLGetDetailFailure(e.toString()));
    }
  }
}
