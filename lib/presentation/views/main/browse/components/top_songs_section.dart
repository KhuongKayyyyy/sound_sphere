import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/presentation/views/main/browse/components/top_song_item.dart';

// ignore: must_be_immutable
class TopSongsSection extends StatelessWidget {
  bool isBlackTitle;
  List<Track> songList;
  TopSongsSection(
      {super.key, required this.songList, required this.isBlackTitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: !isBlackTitle
                    ? [Theme.of(context).primaryColor, Colors.purple]
                    : [Colors.black, Colors.black],
                tileMode: TileMode.mirror,
              ).createShader(bounds),
              child: InkWell(
                onTap: () {
                  context.pushNamed(
                    Routes.extendedList,
                    extra: {
                      'songs': songList,
                      'title': "Top Songs",
                    },
                  );
                },
                child: const Row(
                  children: [
                    Text(
                      "Top Songs",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    ),
                    SizedBox(width: 10),
                    Icon(CupertinoIcons.forward, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.symmetric(vertical: 10),
              scrollDirection:
                  Axis.horizontal, // Change to horizontal scrolling
              crossAxisCount: 3,
              childAspectRatio: 0.2,
              crossAxisSpacing: 10,
              children: List.generate(songList.take(9).length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TopSongItem(
                    song: songList[index],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
