import 'package:flutter/material.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'playlist_section.dart';

class BrowseHomePage extends StatelessWidget {
  const BrowseHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 20),
              child: Text("Browse",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
            ),
            PlaylistSection(
                imageList: FakeData.chrismastPlaylistImg, isBig: true),
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 10),
              child: Text("Happy new year!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
            ),
            PlaylistSection(
                imageList: FakeData.newYearPlaylistImg, isBig: false),
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 10, top: 10),
              child: Text("Best of 2024",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
            ),
            PlaylistSection(
                imageList: FakeData.newYearPlaylistImg, isBig: false),
          ],
        ),
      ),
    );
  }
}
