import 'package:flutter/material.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/views/home/components/added_artist_button.dart';
import 'package:sound_sphere/presentation/views/home/components/best_album_section.dart';
import 'package:sound_sphere/presentation/views/home/components/history_playlist_button.dart';
import 'package:sound_sphere/presentation/views/home/components/mixed_playlist.dart';
import 'package:sound_sphere/presentation/views/home/components/playlist_section.dart';
import 'package:sound_sphere/presentation/views/home/components/song_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text(
            'Browse',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              width: 50,
              height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  FakeData.user.avatarURL,
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          AddedArtist(
                              myArtistList: FakeData.artists.take(3).toList()),
                          const Spacer(),
                          HistoryPlaylist(),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const MixedPlaylistSmall(),
                    ],
                  )),
              PlaylistSection(playlistSectionTitle: "Top Playlists"),
              SongSection(
                songSectionTitle: "Today hits",
                songList: FakeData.songs.take(10).toList(),
                isExpandable: true,
              ),
              const SizedBox(
                height: 10,
              ),
              PlaylistSection(playlistSectionTitle: "Made for you"),
              const SizedBox(
                height: 10,
              ),
              SongSection(
                songSectionTitle: "Son Tung MTP's fan like",
                songList: FakeData.songs.take(10).toList(),
                isExpandable: false,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: BestAlbumSection()),
              const SizedBox(height: 150),
            ],
          ),
        ));
  }
}
