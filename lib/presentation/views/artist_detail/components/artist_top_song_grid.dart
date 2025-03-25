import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/presentation/widgets/track/track_item.dart';

class ArtistTopSongGrid extends StatelessWidget {
  final List<Track> topSongs;
  const ArtistTopSongGrid({super.key, required this.topSongs});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: InkWell(
            onTap: () {
              context.pushNamed(Routes.extendedList, extra: {
                "songs": topSongs,
                "title": "Top Songs",
              });
            },
            child: Column(
              children: [
                const Row(
                  children: [
                    Text(
                      "Top Songs ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        if (topSongs.length <= 4)
          SizedBox(
              height:
                  MediaQuery.of(context).size.height * 0.1 * topSongs.length,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: topSongs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TrackItem(
                      isSliable: false,
                      track: topSongs[index],
                    ),
                  );
                },
              ))
        else
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisExtent: MediaQuery.of(context).size.height * 0.4,
              ),
              itemCount: topSongs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TrackItem(
                    track: topSongs[index],
                    isSliable: false,
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
