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
