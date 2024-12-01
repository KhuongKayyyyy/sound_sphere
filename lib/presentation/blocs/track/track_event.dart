part of 'track_bloc.dart';

sealed class TrackEvent extends Equatable {
  const TrackEvent();

  @override
  List<Object> get props => [];
}

class FetchTracksEvent extends TrackEvent {
  final int page;
  final int limit;
  final String select;
  const FetchTracksEvent(this.page, this.limit, this.select);

  @override
  List<Object> get props => [page, limit, select];
}

class FetchTrackDetail extends TrackEvent {
  final String id;
  const FetchTrackDetail(this.id);

  @override
  List<Object> get props => [id];
}

class FetchTracksByArtistEvent extends TrackEvent {
  final String artistId;
  const FetchTracksByArtistEvent(this.artistId);

  @override
  List<Object> get props => [artistId];
}
