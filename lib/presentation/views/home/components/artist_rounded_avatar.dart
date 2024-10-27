import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/artist.dart';

class ArtistRoundedAvatar extends StatefulWidget {
  Artist artist;
  bool isLike;
  ArtistRoundedAvatar({super.key, required this.artist, required this.isLike});

  @override
  State<ArtistRoundedAvatar> createState() => _ArtistRoundedAvatarState();
}

class _ArtistRoundedAvatarState extends State<ArtistRoundedAvatar> {
  get index => null;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              widget.artist.avatarURL,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          widget.artist.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
