import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/data/models/song.dart';

class SongItem extends StatelessWidget {
  Song song;
  SongItem({required this.song});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              imageUrl: song.imgURL,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          song.title,
        ),
        Text(
          song.artistName,
          style: TextStyle(color: AppColor.inkGreyDark),
        )
      ],
    );
  }
}
