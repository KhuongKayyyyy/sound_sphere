import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/song.dart';
import 'package:sound_sphere/presentation/widgets/song/song_item.dart';

// ignore: must_be_immutable
class SongSection extends StatelessWidget {
  String songSectionTitle;
  List<Song> songList;
  bool isExpandable;
  final VoidCallback? onPressed;
  SongSection(
      {super.key,
      required this.songSectionTitle,
      required this.songList,
      required this.isExpandable,
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
                songSectionTitle,
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
        SizedBox(
          height: 210,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemCount: songList.length,
            itemBuilder: (context, index) {
              Song song = songList.elementAt(index);
              return Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SongItem(song: song),
              );
            },
          ),
        )
      ],
    );
  }
}
