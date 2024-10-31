import 'package:flutter/material.dart';

class PlaylistItem extends StatelessWidget {
  final String img;
  final bool isBig;

  const PlaylistItem({
    required this.img,
    required this.isBig,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: isBig ? 150 : 180,
          width: isBig ? 330 : 180,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              img,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          isBig ? "Your New Year Starts Here!" : "Midnight Countdown",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          isBig
              ? "Wave goodbye to 2021 with these incredible tracks"
              : "SoundSphere Music Party",
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
