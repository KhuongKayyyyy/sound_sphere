import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_sphere/core/constant/api_config.dart';
import 'package:sound_sphere/core/error/app_error.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/presentation/blocs/track/track_bloc.dart';
import 'package:sound_sphere/presentation/widgets/track/track_item.dart';

class AllSongList extends StatefulWidget {
  final List<Track> songs;
  final String title;
  const AllSongList({super.key, required this.songs, required this.title});

  @override
  State<AllSongList> createState() => _AllSongListState();
}

class _AllSongListState extends State<AllSongList> {
  late TrackBloc trackBloc;
  @override
  void initState() {
    super.initState();
    trackBloc = TrackBloc();
    trackBloc.add(FetchTracksEvent(3, 10, TrackApi.previewTrack));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<TrackBloc, TrackState>(
        bloc: trackBloc,
        builder: (context, trackState) {
          if (trackState is TracksLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (trackState is TracksLoaded) {
            return ListView.builder(
              itemCount: trackState.tracks.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TrackItem(
                      song: trackState.tracks.elementAt(index), isLiked: false),
                );
              },
            );
          } else if (trackState is TracksError) {
            return Text(trackState.message);
          }
          return Text(AppError.noAddEvent);
        },
      ),
    );
  }
}
