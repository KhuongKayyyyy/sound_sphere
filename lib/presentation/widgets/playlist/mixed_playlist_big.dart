import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/data/models/artist.dart';

class MixedPlaylistBig extends StatelessWidget {
  String mixedPlaylistTitle;
  List<Artist> artistList;
  MixedPlaylistBig(
      {required this.artistList, required this.mixedPlaylistTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColor.primaryColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.music_video,
                  color: Colors.white,
                ),
                Text(
                  mixedPlaylistTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Mix!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                color: AppColor.primaryColor),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 5),
              child: Text(
                getAllArtistNames(artistList),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  String getAllArtistNames(List<Artist> artists) {
    return artists.map((artist) => artist.name).join(", ");
  }
}
