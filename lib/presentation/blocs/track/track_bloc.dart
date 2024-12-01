import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/data/res/track_repository.dart';

part 'track_event.dart';
part 'track_state.dart';

class TrackBloc extends Bloc<TrackEvent, TrackState> {
  TrackBloc() : super(TrackInitial()) {
    on<TrackEvent>((event, emit) {});
    on<FetchTracksEvent>(_onFetchTracksEvent);
  }

  Future<void> _onFetchTracksEvent(
      FetchTracksEvent event, Emitter<TrackState> emit) async {
    emit(TrackLoading());
    try {
      final tracks = await TrackRepository.fetchTrackWithPreview(
          event.page, event.limit, event.select);
      emit(TrackLoaded(tracks));
    } catch (e) {
      emit(TrackError(e.toString()));
    }
  }
}
