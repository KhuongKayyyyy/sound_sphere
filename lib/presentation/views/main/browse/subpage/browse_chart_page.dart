import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/blocs/track/track_bloc.dart';
import 'package:sound_sphere/presentation/views/main/browse/components/city_chart_section.dart';
import 'package:sound_sphere/presentation/views/main/browse/components/daily_top_100_section.dart';
import 'package:sound_sphere/presentation/views/main/browse/components/top_songs_section.dart';
import 'package:sound_sphere/presentation/views/main/home/components/media_section.dart';

class BrowseChartPage extends StatefulWidget {
  const BrowseChartPage({super.key});

  @override
  State<BrowseChartPage> createState() => _BrowseChartPageState();
}

class _BrowseChartPageState extends State<BrowseChartPage> {
  late TrackBloc trackBloc;

  @override
  void initState() {
    super.initState();
    trackBloc = TrackBloc();
    trackBloc.add(FetchTopTrack());
  }

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
            BlocBuilder<TrackBloc, TrackState>(
              bloc: trackBloc,
              builder: (context, trackState) {
                if (trackState is TopTrackLoading) {
                  return Skeletonizer(
                      child: TopSongsSection(
                    songList: FakeData.obitoSongs.take(8).toList(),
                    isBlackTitle: false,
                  ));
                } else if (trackState is TopTrackError) {
                  return Center(child: Text(trackState.message));
                } else if (trackState is TopTrackLoaded) {
                  return TopSongsSection(
                    songList: trackState.tracks,
                    isBlackTitle: false,
                  );
                }
                return const SizedBox();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            DailyTop100Section(),
            CityChartSection(),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: MediaSection(
                  mediaSectionTitle: "Everyone talking about",
                  songList: FakeData.obitoSongs.take(8).toList(),
                  isExpandable: true,
                  onPressed: () {
                    context.pushNamed(Routes.extendGridView, extra: {
                      "songs": FakeData.obitoSongs.take(8).toList(),
                      "title": "Everyone talking about"
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
