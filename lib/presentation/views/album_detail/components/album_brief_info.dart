import 'package:flutter/material.dart';
import 'package:sound_sphere/core/utils/helpers.dart';
import 'package:sound_sphere/data/models/album.dart';

class AlbumBriefInfo extends StatelessWidget {
  final Album album;

  const AlbumBriefInfo({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(Helpers.formatDate(album.releaseDate),
                style: const TextStyle(color: Colors.grey)),
            Text("${album.tracks.length} songs, ${album.getAlbumDuration()}"),
            Text(
                "© ${album.aritst} ${Helpers.getYearFromReleaseDate(album.releaseDate)}"),
          ],
        ),
      ),
    );
  }
}
