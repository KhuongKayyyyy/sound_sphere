import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_sphere/core/constant/api_config.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/data/models/track_in_library.dart';
import 'package:sound_sphere/data/res/library_repository.dart';
import 'package:sound_sphere/data/res/track_repository.dart';

part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final LibraryRepository _libraryRepository = LibraryRepository();
  LibraryBloc() : super(LibraryInitial()) {
    on<LibraryEvent>((event, emit) {});
    on<GetTrackLibraryRequest>(_onGetTrackLibraryRequest);
    on<CheckIfTrackIsFavorite>(_onCheckIfTrackIsFavorite);
    on<ToggleTrackFavorite>(_onToggleTrackFavorite);
    on<AddTrackToFavorites>(_onAddTrackToFavorites);
    on<RemoveTrackFromLibRequest>(_onRemoveTrackFromLibRequest);
    on<AddTrackToLibraryRequest>(_onAddTrackToLibraryRequest);
    on<GetFavoriteTracksRequest>(_onGetFavoriteTracksRequest);
  }

  Future<void> _onGetFavoriteTracksRequest(
    GetFavoriteTracksRequest event,
    Emitter<LibraryState> emit,
  ) async {
    emit(LibraryLoading());
    try {
      final favoriteLibrary =
          await _libraryRepository.getFavoriteTracks(page: 1, limit: 100);
      final List<Track> tracks = [];
      for (var track in favoriteLibrary) {
        final realTrack = await TrackRepository.getTrackDetailById(
            track.id!, TrackApi.previewTrack);
        tracks.add(realTrack);
      }
      emit(GetFavoriteTracksRequestSuccess(
          favoriteTracks: favoriteLibrary, tracks: tracks));
    } catch (e) {
      emit(GetFavoriteTracksRequestError(e.toString()));
    }
  }

  Future<void> _onAddTrackToLibraryRequest(
    AddTrackToLibraryRequest event,
    Emitter<LibraryState> emit,
  ) async {
    emit(LibraryLoading());
    try {
      await _libraryRepository.addTrackToLibrary(event.trackId);
      emit(AddTrackToLibrarySuccess());
    } catch (e) {
      emit(AddTrackToLibraryError(e.toString()));
    }
  }

  Future<void> _onRemoveTrackFromLibRequest(
    RemoveTrackFromLibRequest event,
    Emitter<LibraryState> emit,
  ) async {
    emit(LibraryLoading());
    try {
      await _libraryRepository.removeTrackFromLibrary(event.trackId);
      emit(RemoveTrackFromLibSuccess());
      add(GetTrackLibraryRequest());
    } catch (e) {
      emit(RemoveTrackFromLibError(e.toString()));
    }
  }

  Future<void> _onAddTrackToFavorites(
    AddTrackToFavorites event,
    Emitter<LibraryState> emit,
  ) async {
    emit(LibraryLoading());
    try {
      await _libraryRepository.addFavoriteTrack(trackId: event.trackId);
      emit(AddTrackToFavoritesSuccess());
    } catch (e) {
      emit(AddTrackToFavoritesError(e.toString()));
    }
  }

  Future<void> _onToggleTrackFavorite(
    ToggleTrackFavorite event,
    Emitter<LibraryState> emit,
  ) async {
    emit(ToggleTrackFavoriteLoading());
    try {
      await _libraryRepository.toggleFavoriteOfTrack(
        trackId: event.track.id!,
        isFavorite: event.isFavorite,
      );
      emit(ToggleTrackFavoriteSuccess(event.isFavorite));
    } catch (e) {
      emit(ToggleTrackFavoriteError(e.toString()));
    }
  }

  Future<void> _onCheckIfTrackIsFavorite(
    CheckIfTrackIsFavorite event,
    Emitter<LibraryState> emit,
  ) async {
    emit(LibraryLoading());
    try {
      final isFavorite = await _libraryRepository.isTrackFavorite(
        trackId: event.trackId,
      );
      emit(CheckTrackFavoriteSuccess(isFavorite));
    } catch (e) {
      emit(CheckTrackFavoriteError(e.toString()));
    }
  }

  Future<void> _onGetTrackLibraryRequest(
    GetTrackLibraryRequest event,
    Emitter<LibraryState> emit,
  ) async {
    emit(LibraryLoading());
    try {
      final library =
          await _libraryRepository.getTrackLibrary(page: 1, limit: 100);
      final favoriteLibrary =
          await _libraryRepository.getFavoriteTracks(page: 1, limit: 100);
      List<Track> tracks = [];
      for (var track in library) {
        final realTrack = await TrackRepository.getTrackDetailById(
            track.id!, TrackApi.previewTrack);
        tracks.add(realTrack);
      }
      emit(TrackLibraryLoaded(tracks: tracks, favoriteTracks: favoriteLibrary));
    } catch (e) {
      emit(TrackLibraryError(e.toString()));
    }
  }
}
