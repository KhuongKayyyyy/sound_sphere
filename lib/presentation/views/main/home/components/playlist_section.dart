import 'package:flutter/material.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/widgets/playlist/mixed_playlist_big.dart';

class PlaylistSection extends StatelessWidget {
  final String playlistSectionTitle;

  const PlaylistSection({super.key, required this.playlistSectionTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            playlistSectionTitle,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              List<String> title = ["GET UP!", "CHILL", "NEW MUSIC"];
              return Padding(
                padding: const EdgeInsets.only(left: 10),
                child: MixedPlaylistBig(
                  artistList: FakeData.artists.take(5).toList(),
                  mixedPlaylistTitle: title.elementAt(index),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
