import 'package:flutter/material.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/artist.dart';

class ArtistRoundedAvatar extends StatelessWidget {
  final Artist artist;
  final bool isLike;
  final VoidCallback onTap;

  const ArtistRoundedAvatar({
    super.key,
    required this.artist,
    required this.isLike,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            InkWell(
              onTap: onTap,
              child: SizedBox(
                height: 100,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    artist.avatarURL ??
                        FakeData.artists.first.avatarURL!, // Fallback image
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.person, // Show a default icon if image fails
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            if (isLike)
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.5),
                ),
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
          artist.name ?? "Unknown Artist", // Avoid null issue
          style: const TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
