import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/album.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/presentation/widgets/album/album_item.dart';
import 'package:sound_sphere/presentation/widgets/media/media_item.dart';

// ignore: must_be_immutable
class ArtistMusic extends StatelessWidget {
  String sectionName;
  List<Track>? songList;
  List<Album>? albumList;
  ArtistMusic(
      {super.key, required this.sectionName, this.songList, this.albumList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: InkWell(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  sectionName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w900),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey,
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        if (songList != null)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: songList?.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: index == 0 ? 20 : 10),
                  child: MediaItem(track: songList![index]),
                );
              },
            ),
          ),
        if (albumList != null)
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: albumList?.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: AlbumItem(album: albumList![index]));
              },
            ),
          ),
      ],
    );
  }
}
