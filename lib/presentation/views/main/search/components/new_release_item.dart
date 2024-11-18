import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/album.dart';
import 'package:sound_sphere/data/models/song.dart';

class NewReleaseItem extends StatelessWidget {
  final Album? album;
  final Song? song;
  const NewReleaseItem({super.key, this.album, this.song});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          album != null ? "New Album" : "New EP",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            fontSize: 15,
          ),
        ),
        Text(
          album != null ? album!.title : song!.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          album != null ? album!.artistName : song!.artistName,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 5),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            album != null ? album!.imgURL : song!.imgURL,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width - 60,
            height: 200,
          ),
        )
      ],
    );
  }
}
