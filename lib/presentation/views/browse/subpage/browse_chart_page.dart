import 'package:flutter/material.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/views/browse/components/city_chart_section.dart';
import 'package:sound_sphere/presentation/views/browse/components/daily_top_100_section.dart';
import 'package:sound_sphere/presentation/views/browse/components/top_songs_section.dart';
import 'package:sound_sphere/presentation/views/home/components/song_section.dart';

class BrowseChartPage extends StatefulWidget {
  const BrowseChartPage({super.key});

  @override
  State<BrowseChartPage> createState() => _BrowseChartPageState();
}

class _BrowseChartPageState extends State<BrowseChartPage> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 20),
              child: Text("Chart",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
            ),
            TopSongsSection(songList: FakeData.songs.take(9).toList()),
            const SizedBox(
              height: 20,
            ),
            DailyTop100Section(),
            CityChartSection(),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SongSection(
                  songSectionTitle: "Everyone talking about",
                  songList: FakeData.songs.take(8).toList(),
                  isExpandable: true),
            )
          ],
        ),
      ),
    );
  }
}
