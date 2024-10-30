import 'package:flutter/material.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/views/browse/components/music_by_genres_section.dart';
import '../components/playlist_section.dart';

class BrowseGenresPage extends StatelessWidget {
  const BrowseGenresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 20),
              child: Text("Genres",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
            ),
            PlaylistSection(imageList: FakeData().rockAlbumCover, isBig: true),
            MusicByGenresSection(
              sectionTitle: "Music by Genres",
              genresList: FakeData.genres,
            ),
            MusicByGenresSection(
              sectionTitle: "Suit your mood",
              genresList: FakeData.moodList,
            ),
          ],
        ),
      ),
    );
  }
}
