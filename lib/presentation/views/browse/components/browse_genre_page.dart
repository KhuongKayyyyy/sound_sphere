import 'package:flutter/material.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'playlist_section.dart';

class BrowseGenresPage extends StatelessWidget {
  const BrowseGenresPage({Key? key}) : super(key: key);

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
          ],
        ),
      ),
    );
  }
}
