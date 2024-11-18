import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/views/main/search/components/search_song_item.dart';

class SearchHistory extends StatefulWidget {
  const SearchHistory({super.key});

  @override
  State<SearchHistory> createState() => _SearchHistoryState();
}

class _SearchHistoryState extends State<SearchHistory> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                "Recently Searched",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: InkWell(
                  onTap: () {},
                  child: Text("Clear",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.primaryColor,
                      )),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Container(
            width: double.infinity,
            height: 0.5,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          // Directly use ListView.builder without wrapping it in SizedBox
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SearchSongItem(song: FakeData.obitoSongs[index]),
              );
            },
          ),
        ],
      ),
    );
  }
}
