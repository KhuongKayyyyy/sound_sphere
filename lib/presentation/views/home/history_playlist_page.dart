import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/song.dart';
import 'package:sound_sphere/presentation/widgets/search_bar/custom_search_bar.dart';
import 'package:sound_sphere/presentation/widgets/track/track_item.dart';

class HistoryPlaylistPage extends StatelessWidget {
  final List<Song> songList = FakeData.songs.take(10).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listening History"),
        actions: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColor.inkGreyLight,
            ),
            child: IconButton(
              onPressed: () {},
              icon:
                  Icon(Icons.notifications_none, color: AppColor.primaryColor),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 10),
            CustomSearchBar(
              textHint: "What should we listen to?",
              isWhite: false,
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: songList.length,
                itemBuilder: (context, index) {
                  // Determine whether to set isLiked to true or false based on the index
                  bool isLiked = index % 2 == 0;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: TrackItem(song: songList[index], isLiked: isLiked),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
