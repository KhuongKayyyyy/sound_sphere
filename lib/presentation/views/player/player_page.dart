import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/song.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  Song currentSong = FakeData.songs[2];
  bool _isPlaying = false; // Track play/pause state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          ..._buildPlayerBackground(),
          // Other UI elements go here, e.g., song controls
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 70),

                // Drag down widget
                Center(
                  child: Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(height: 80),

                // Song image with scaling effect
                _buildSongImage(),

                const SizedBox(height: 80),
                _buildSongPlayControl(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSongImage() {
    return Center(
      child: AnimatedScale(
        scale: _isPlaying ? 1.4 : 1.0, // 1.2 for 300x300, 1.0 for 250x250
        duration: const Duration(milliseconds: 300), // Animation duration
        curve: Curves.easeInOut, // Smooth easing effect
        child: Container(
          height: 250, // Base size
          width: 250,
          decoration: BoxDecoration(
            boxShadow: _isPlaying
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 10,
                    ),
                  ]
                : [],
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(currentSong.imgURL),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite,
                      color: AppColor.primaryColor,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz_rounded,
                      color: AppColor.primaryColor,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSongPlayControl() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            currentSong.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            currentSong.artistName,
            style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: LinearProgressIndicator(
                value:
                    0.2, // This should be a variable representing the current position of the song
                backgroundColor: Colors.white.withOpacity(0.5),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    // Handle previous song action
                  },
                  child: Image.asset(
                    AppIcon.play_previous,
                    scale: 15,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isPlaying = !_isPlaying; // Toggle play/pause state
                    });
                  },
                  icon: Icon(
                    _isPlaying
                        ? Icons.pause_rounded
                        : Icons
                            .play_arrow_rounded, // Switch icon based on play/pause state
                    color: Colors.white,
                    size: 70,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Handle next song action
                  },
                  child: Image.asset(
                    AppIcon.play_next,
                    scale: 15,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          // function
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                child: Image.asset(
                  AppIcon.lyrics,
                  scale: 20,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              InkWell(
                child: Image.asset(
                  AppIcon.airplay,
                  scale: 20,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.timer_sharp,
                    color: Colors.white.withOpacity(0.7),
                    size: 35,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.list_rounded,
                    color: Colors.white.withOpacity(0.7),
                    size: 35,
                  ))
            ],
          )
        ],
      ),
    );
  }

  List<Widget> _buildPlayerBackground() {
    return [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(currentSong.imgURL),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Positioned.fill(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1000, sigmaY: 1000),
          child: Container(
            color: Colors.black.withOpacity(0.2),
          ),
        ),
      )
    ];
  }
}
