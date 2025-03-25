import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/data/models/track_in_library.dart';
import 'package:sound_sphere/presentation/widgets/track/track_item.dart';

class AlbumSongList extends StatelessWidget {
  final List<Track> tracks;
  final List<TrackInLibrary> favoriteTracks;

  const AlbumSongList(
      {super.key, required this.tracks, required this.favoriteTracks});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final isFavorite =
              favoriteTracks.any((favTrack) => favTrack.id == tracks[index].id);
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: isFavorite ? 0 : 10),
                child: TrackItem(
                  index: index + 1,
                  track: tracks[index],
                  isFavorite: isFavorite,
                ),
              )
            ],
          );
        },
        childCount: tracks.length,
      ),
    );
  }
}
