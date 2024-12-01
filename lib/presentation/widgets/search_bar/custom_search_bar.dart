import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/artist.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/presentation/widgets/artist/artist_searched_item.dart';

// ignore: must_be_immutable
class CustomSearchBar extends StatelessWidget {
  String textHint;
  bool isWhite;

  CustomSearchBar({super.key, required this.textHint, required this.isWhite});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showSearch(
          context: context,
          delegate: CustomSearchDelegate(),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isWhite ? Colors.white : Colors.grey[100],
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search, // Search icon at the beginning
              color: Colors.grey,
            ),
            const SizedBox(width: 8), // Space between icon and text
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: textHint,
                  hintStyle: TextStyle(
                    color: AppColor.inkGrey, // Text color
                  ),
                  border: InputBorder.none, // Remove underline border
                ),
                style: const TextStyle(
                  color: Colors.black, // Text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<Artist> searchArist = FakeData.artists.take(5).toList();
  List<Track> songList = FakeData.obitoSongs.take(5).toList();
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: Colors.black),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Artist> matchQuery = [];
    for (var artist in searchArist) {
      if (artist.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(artist);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (matchQuery.isNotEmpty)
            const Text(
              "Search Result",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: matchQuery.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ArtistSearchItem(
                    artist: matchQuery[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Artist> matchQuery = [];
    for (var artist in searchArist) {
      if (artist.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(artist);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (query.isEmpty)
            const Text(
              "Recent Searches",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: matchQuery.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ArtistSearchItem(
                    artist: matchQuery[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
