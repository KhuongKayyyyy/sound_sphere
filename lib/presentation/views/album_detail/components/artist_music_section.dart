import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/album.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/presentation/widgets/album/album_item.dart';
import 'package:sound_sphere/presentation/widgets/media/media_item.dart';

class ArtistMusicSection extends StatelessWidget {
  final String title;
  final List<Track>? songs;
  final List<Album>? albums;

  const ArtistMusicSection(
      {super.key, required this.title, this.songs, this.albums});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ],
          ),
        ),
        const SizedBox(height: 10),
        if (songs != null)
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: songs!.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 20),
                child: MediaItem(track: songs![index]),
              ),
            ),
          ),
        if (albums != null)
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: albums!.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 20),
                child: AlbumItem(album: albums![index]),
              ),
            ),
          ),
      ],
    );
  }
}
