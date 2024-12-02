import 'package:flutter/material.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/artist.dart';

// ignore: must_be_immutable
class ArtistRoundedAvatar extends StatefulWidget {
  Artist artist;
  bool isLike;
  VoidCallback onTap;
  ArtistRoundedAvatar(
      {super.key,
      required this.artist,
      required this.isLike,
      required this.onTap});

  @override
  State<ArtistRoundedAvatar> createState() => _ArtistRoundedAvatarState();
}

class _ArtistRoundedAvatarState extends State<ArtistRoundedAvatar> {
  get index => null;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            InkWell(
              onTap: widget.onTap,
              child: SizedBox(
                height: 100,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    FakeData.artists.first.avatarURL!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            if (widget.isLike)
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.5)),
                child: const Center(
                  child: Icon(
                    Icons.favorite,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              )
          ],
        ),
        const SizedBox(height: 10),
        Text(
          widget.artist.name!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
