import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/artist.dart';

class ArtistNameItem extends StatelessWidget {
  final Artist artist;
  final bool isBlackText;

  ArtistNameItem({super.key, required this.artist, this.isBlackText = false});

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      fontSize: 16,
      color: isBlackText ? Colors.black : Colors.white,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isBlackText ? Colors.white : Colors.black,
      ),
      child: Text(
        artist.name,
        style: textStyle,
      ),
    );
  }
}
