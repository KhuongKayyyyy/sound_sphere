import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/genres.dart';
import 'dart:math';

class GenresItem extends StatelessWidget {
  final Genres genres;

  const GenresItem({super.key, required this.genres});

  // Function to generate a random color
  Color _randomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256), // Random red
      random.nextInt(256), // Random green
      random.nextInt(256), // Random blue
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Set the width for each genre item
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _randomColor(),
            _randomColor(),
            _randomColor(),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            genres.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
