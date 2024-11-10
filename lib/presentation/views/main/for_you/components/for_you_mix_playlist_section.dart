import 'dart:math';
import 'package:flutter/material.dart';

class ForYouMixPlaylistSection extends StatelessWidget {
  const ForYouMixPlaylistSection({super.key});

  // Method to generate random colors
  Color _randomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(width: 10),
          _buildMixPlaylistCardBig("Daily Mix"),
          const SizedBox(width: 10),
          Column(
            children: [
              _buildMixPlaylistCardSmall("Chill Mix"),
              const SizedBox(height: 10),
              _buildMixPlaylistCardSmall("Followers Most Listened"),
            ],
          ),
          const SizedBox(width: 10),
          _buildMixPlaylistCardBig("Khuong's Mix"),
        ],
      ),
    );
  }

  Widget _buildMixPlaylistCardBig(String playlistName) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [_randomColor(), _randomColor(), _randomColor()],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            playlistName,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildMixPlaylistCardSmall(String playlistName) {
    return Container(
      width: 150,
      height: 70,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [_randomColor(), _randomColor(), _randomColor()],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          playlistName,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }
}
