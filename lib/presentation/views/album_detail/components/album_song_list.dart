import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/presentation/widgets/track/track_item.dart';

class AlbumSongList extends StatelessWidget {
  final List<Track> tracks;

  const AlbumSongList({super.key, required this.tracks});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Column(
            children: [
              TrackItem(
                index: index + 1,
                track: tracks[index],
              )
            ],
          );
        },
        childCount: tracks.length,
      ),
    );
  }
}
