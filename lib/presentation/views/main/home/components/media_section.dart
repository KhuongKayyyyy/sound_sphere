import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/album.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/presentation/widgets/media/media_item.dart';

// ignore: must_be_immutable
class MediaSection extends StatelessWidget {
  String mediaSectionTitle;
  List<Track>? songList;
  List<Album>? albumList;
  bool isExpandable;
  final VoidCallback? onPressed;
  MediaSection(
      {super.key,
      required this.mediaSectionTitle,
      this.songList,
      required this.isExpandable,
      this.albumList,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Text(
                mediaSectionTitle,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Spacer(),
              IconButton(
                onPressed: isExpandable
                    ? onPressed
                    : null, // Make button clickable only if isExpandable is true
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: isExpandable
                      ? null
                      : Colors
                          .white, // Change color based on isExpandable state
                ),
                padding: EdgeInsets.zero,
              )
            ],
          ),
        ),
        if (songList != null)
          SizedBox(
            height: 210,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: songList!.length,
              itemBuilder: (context, index) {
                Track song = songList!.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: MediaItem(track: song),
                );
              },
            ),
          ),
        if (albumList != null)
          SizedBox(
            height: 210,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: albumList!.length,
              itemBuilder: (context, index) {
                Album album = albumList!.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: MediaItem(album: album),
                );
              },
            ),
          )
      ],
    );
  }
}
