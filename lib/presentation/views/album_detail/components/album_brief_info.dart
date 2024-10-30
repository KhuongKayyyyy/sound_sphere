import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/album.dart';

class AlbumBriefInfo extends StatelessWidget {
  final Album tempAlbum;

  const AlbumBriefInfo({Key? key, required this.tempAlbum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tempAlbum.releaseDate,
                style: const TextStyle(color: Colors.grey)),
            Text(
                "${tempAlbum.songs.length} songs, ${tempAlbum.getAlbumDuration()}"),
            Text("© ${tempAlbum.artistName} ${tempAlbum.releaseDate}"),
          ],
        ),
      ),
    );
  }
}
