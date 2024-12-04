import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sound_sphere/core/constant/api_config.dart';
import 'package:sound_sphere/core/error/app_error.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/presentation/blocs/track/track_bloc.dart';
import 'package:sound_sphere/presentation/widgets/track/track_item.dart';

class AllSongList extends StatefulWidget {
  final List<Track> songs;
  final String title;
  final int page;
  final int limit;

  const AllSongList(
      {super.key,
      required this.songs,
      required this.title,
      required this.page,
      required this.limit});

  @override
  State<AllSongList> createState() => _AllSongListState();
}

class _AllSongListState extends State<AllSongList> {
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
      body: BlocBuilder<TrackBloc, TrackState>(
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
      ),
    );
  }
}
