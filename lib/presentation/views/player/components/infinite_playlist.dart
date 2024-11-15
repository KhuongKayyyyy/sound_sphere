import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/views/player/components/playlist_song_list.dart';

class InfinitePlaylist extends StatefulWidget {
  const InfinitePlaylist({super.key});

  @override
  State<InfinitePlaylist> createState() => _InfinitePlaylistState();
}

class _InfinitePlaylistState extends State<InfinitePlaylist> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.2),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      AppIcon.infinity,
                      scale: 15,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Autoplay",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Similar music will kepp playing",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          PlaylistSonglist(
            songList: FakeData.obitoSongs,
            isInfinitePlaylist: true,
          ),
        ],
      ),
    );
  }
}
