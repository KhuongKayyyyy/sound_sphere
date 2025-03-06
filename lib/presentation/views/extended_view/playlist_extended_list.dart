import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sound_sphere/core/constant/api_config.dart';
import 'package:sound_sphere/core/error/app_error.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/presentation/blocs/track/track_bloc.dart';
import 'package:sound_sphere/presentation/widgets/track/track_item.dart';

class PlayListExtendedList extends StatefulWidget {
  final List<Track> tracks;
  final String title;
  final int page;
  final int limit;

  const PlayListExtendedList(
      {super.key,
      required this.tracks,
      required this.title,
      required this.page,
      required this.limit});

  @override
  State<PlayListExtendedList> createState() => _PlayListExtendedListState();
}

class _PlayListExtendedListState extends State<PlayListExtendedList> {
  late TrackBloc trackBloc;

  @override
  void initState() {
    super.initState();
    trackBloc = TrackBloc();
    trackBloc.add(
        FetchTracksEvent(widget.page, widget.limit, TrackApi.previewTrack));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: widget.limit == 0 && widget.page == 0
          ? _buildExistedPlaylist()
          : _buildRandomPlaylist(),
    );
  }

  Widget _buildExistedPlaylist() {
    return ListView.builder(
      itemCount: widget.tracks.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TrackItem(
            track: widget.tracks.elementAt(index),
            isLiked: false,
          ),
        );
      },
    );
  }

  BlocBuilder<TrackBloc, TrackState> _buildRandomPlaylist() {
    return BlocBuilder<TrackBloc, TrackState>(
      bloc: trackBloc,
      builder: (context, trackState) {
        if (trackState is TracksLoading) {
          return Skeletonizer(
            child: ListView.builder(
              itemCount: FakeData.obitoSongs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TrackItem(
                    track: FakeData.obitoSongs.elementAt(index),
                    isLiked: false,
                  ),
                );
              },
            ),
          );
        } else if (trackState is TracksLoaded) {
          return ListView.builder(
            itemCount: trackState.tracks.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TrackItem(
                  track: trackState.tracks.elementAt(index),
                  isLiked: false,
                ),
              );
            },
          );
        } else if (trackState is TracksError) {
          return Center(child: Text(trackState.message));
        }
        return Center(child: Text(AppError.noAddEvent));
      },
    );
  }
}
