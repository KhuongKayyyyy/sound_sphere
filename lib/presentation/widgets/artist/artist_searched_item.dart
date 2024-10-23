import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/artist.dart';

// ignore: must_be_immutable
class ArtistSearchItem extends StatelessWidget {
  Artist artist;
  ArtistSearchItem({super.key, required this.artist});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: artist.avatarURL,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          artist.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.clear,
              color: Colors.grey,
            )),
      ],
    );
  }
}
