import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/artist.dart';

class ArtistItem extends StatelessWidget {
  Artist artist;
  final double size;
  ArtistItem({required this.artist, required this.size});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CachedNetworkImage(
          imageUrl: artist.avatarURL,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
