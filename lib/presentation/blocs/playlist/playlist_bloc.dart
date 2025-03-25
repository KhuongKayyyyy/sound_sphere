import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_sphere/core/constant/api_config.dart';
import 'package:sound_sphere/core/utils/helpers.dart';
import 'package:sound_sphere/data/models/artist.dart';
import 'package:sound_sphere/data/models/user_playlist.dart';
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
    on<PLChangeStateRequested>(_onPlaylistChangeStateRequested);
    on<PLAddAlbumToPlaylistRequested>(_onAddAlbumToPlaylistRequested);
    on<PLDeleteRequested>(_onPlaylistDeleteRequested);
  }

  void _onPlaylistDeleteRequested(
      PLDeleteRequested event, Emitter<PlaylistState> emit) async {
    emit(PLDeleteLoading());
    try {
      final playlist = await _playlistRepository.deletePlaylist(
          playlistId: event.playlistId);
      emit(PLDeleteSuccess(playlist));
    } catch (e) {
      emit(PLDeleteFailure(e.toString()));
    }
  }

  void _onAddAlbumToPlaylistRequested(
      PLAddAlbumToPlaylistRequested event, Emitter<PlaylistState> emit) async {
    emit(PLAddTrackLoading());
    try {
      final playlist = await _playlistRepository.addAlbumToPlayList(
          playlistId: event.playlistId, albumId: event.albumId);
      emit(PLAddTrackSuccess(playlist));
    } catch (e) {
      emit(PLAddTrackFailure(e.toString()));
    }
  }

  void _onPlaylistChangeStateRequested(
      PLChangeStateRequested event, Emitter<PlaylistState> emit) async {
    emit(PLChangeStateLoading());
    try {
      List<UserPlaylist> newPlaylist = [];
      for (var playlist in event.playlists) {
        if (playlist.isPublic! == true) {
          final tempPlaylist = await _playlistRepository.switchToPrivate(
              playlistID: playlist.id!);
          newPlaylist.add(tempPlaylist);
          print(
              "Updated Playlist: ${tempPlaylist.name} - isPublic: ${tempPlaylist.isPublic}");
        } else {
          final tempPlaylist = await _playlistRepository.switchToPublic(
              playlistID: playlist.id!);
          print(
              "Updated Playlist: ${tempPlaylist.name} - isPublic: ${tempPlaylist.isPublic}");

          newPlaylist.add(tempPlaylist);
        }
      }
      emit(PLChangeStateSuccess(newPlaylist));
    } catch (e) {
      emit(PLChangeStateFailure(e.toString()));
    }
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
      final UserPlaylist playlist = await _playlistRepository.createNewPlaylist(
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
      final List<UserPlaylist> playlists =
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
        tracks.add(await TrackRepository.getTrackDetailById(
            track.id, TrackApi.fullTrack));
      }
      List<Artist> artists = Helpers.getArtistsFromTracks(tracks);
      emit(PLGetDetailSuccess(tracks, artists));
    } catch (e) {
      emit(PLGetDetailFailure(e.toString()));
    }
  }
}
