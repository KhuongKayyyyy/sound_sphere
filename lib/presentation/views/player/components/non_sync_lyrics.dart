import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_sphere/core/controller/player_controller.dart';
import 'package:sound_sphere/presentation/blocs/track/track_bloc.dart';

// ignore: must_be_immutable
class NonSyncLyrics extends StatefulWidget {
  final String trackId;
  final ScrollController lyricsScrollController;
  final PlayerController playerController = PlayerController();
  NonSyncLyrics({
    super.key,
    required this.lyricsScrollController,
    required this.trackId,
  });

  @override
  State<NonSyncLyrics> createState() => _NonSyncLyricsState();
}

class _NonSyncLyricsState extends State<NonSyncLyrics> {
  late TrackBloc trackBloc;
  @override
  void initState() {
    super.initState();

    trackBloc = TrackBloc();
    trackBloc.add(FetchTrackLyrics(widget.trackId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackBloc, TrackState>(
      bloc: trackBloc,
      builder: (context, lyricState) {
        if (lyricState is TrackLyricsLoaded) {
          return SingleChildScrollView(
            controller: widget.lyricsScrollController,
            child: SizedBox(
                width: double.infinity,
                child: AnimatedBuilder(
                  animation: widget.playerController,
                  builder: (context, builder) => Text(
                    lyricState.lyrics,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.w900,
                        height: 1.5,
                        fontSize: 35),
                  ),
                )),
          );
        } else if (lyricState is TrackDetailError) {
          return Center(
            child: Text(lyricState.message),
          );
        } else if (lyricState is TrackDetailLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Center(
          child: Text("No available lyric for this song"),
        );
      },
    );
  }
}
