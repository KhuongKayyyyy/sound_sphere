import 'dart:math';
import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/artist.dart';

class MixedPlaylistBig extends StatefulWidget {
  final String mixedPlaylistTitle;
  final List<Artist> artistList;

  const MixedPlaylistBig({
    super.key,
    required this.artistList,
    required this.mixedPlaylistTitle,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MixedPlaylistBigState createState() => _MixedPlaylistBigState();
}

class _MixedPlaylistBigState extends State<MixedPlaylistBig>
    with TickerProviderStateMixin {
  // Initialize colors at declaration to avoid LateInitializationError
  final Color particleColor = _generateRandomColor();

  static Color _generateRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: particleColor.withOpacity(0.3),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      width: 170, // Constrain the size of the AnimatedBackground
      child: AnimatedBackground(
        vsync: this,
        behaviour: RandomParticleBehaviour(
          options: ParticleOptions(
            baseColor: particleColor,
            spawnMinSpeed: 10,
            spawnMaxSpeed: 100,
            spawnMinRadius: 5,
            spawnMaxRadius: 10,
            particleCount: 30,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.transparent,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.music_video,
                      color: particleColor,
                    ),
                    Text(
                      widget.mixedPlaylistTitle,
                      style: TextStyle(
                        color: particleColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Mix!",
                      style: TextStyle(
                        color: particleColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                  color: particleColor.withOpacity(0.8),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10, top: 5),
                  child: Text(
                    getAllArtistNames(widget.artistList),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getAllArtistNames(List<Artist> artists) {
    return artists.map((artist) => artist.name).join(", ");
  }
}
