import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/data/models/album.dart';

// ignore: must_be_immutable
class AlbumItem extends StatelessWidget {
  Album album;
  AlbumItem({super.key, required this.album});
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
              imageUrl: album.imgURL,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          album.title,
        ),
        Text(
          album.aritst,
          style: TextStyle(color: AppColor.inkGreyDark),
        )
      ],
    );
  }
}
