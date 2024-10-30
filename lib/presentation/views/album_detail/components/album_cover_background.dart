import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/data/models/album.dart';

class AlbumCoverBackground extends StatelessWidget {
  final Album tempAlbum;

  const AlbumCoverBackground({
    Key? key,
    required this.tempAlbum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(tempAlbum.imgURL),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(tempAlbum.title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),
          const SizedBox(height: 10),
          Text(tempAlbum.artistName,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          const SizedBox(height: 10),
          AlbumMetadata(tempAlbum: tempAlbum),
        ],
      ),
    );
  }
}

class AlbumMetadata extends StatelessWidget {
  final Album tempAlbum;

  const AlbumMetadata({
    Key? key,
    required this.tempAlbum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${tempAlbum.genre.name} · ${tempAlbum.releaseDate}",
            style: const TextStyle(color: Colors.white, fontSize: 15)),
        const SizedBox(width: 10),
        Image.asset(AppIcon.audio, color: Colors.white, height: 20),
      ],
    );
  }
}
