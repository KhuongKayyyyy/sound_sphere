import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/artist.dart';

class HorizontalArtistItem extends StatelessWidget {
  final Artist artist;
  const HorizontalArtistItem({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(artist.avatarURL!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              // Ensures text and divider take full width
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to left
                children: [
                  Text(
                    artist.name!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(
          // Divider spans across the whole row
          color: Colors.grey,
          thickness: 0.5,
        ),
      ],
    );
  }
}
