import 'package:flutter/material.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/artist.dart';

class ArtistWeLoveItem extends StatelessWidget {
  final Artist artist;
  const ArtistWeLoveItem({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  artist.avatarURL,
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      artist.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios_rounded),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
