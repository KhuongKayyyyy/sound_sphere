import 'dart:math';
import 'dart:ui'; // Import for ImageFilter
import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/genres.dart';

class LibraryGenreItem extends StatelessWidget {
  final Genres genre;
  const LibraryGenreItem({super.key, required this.genre});

  // Generates a random color
  Color _getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color containerColor1 = _getRandomColor(); // First color for gradient
    Color containerColor2 = _getRandomColor(); // Second color for gradient
    Color darkColor = Color.fromARGB(
        255,
        containerColor1.red ~/ 2,
        containerColor1.green ~/ 2,
        containerColor1.blue ~/ 2); // Darker color for the rectangle
    Color circleColor = _getRandomColor(); // Color for the inner circle

    return Row(
      children: [
        Container(
          width: 80, // Width of the main container
          height: 80, // Height of the main container
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [containerColor1, containerColor2], // Gradient colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Center(
                  child: Transform.rotate(
                    angle: pi / 4, // Rotate 45 degrees (pi/4 radians)
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10.0, // Increased blur effect
                          sigmaY: 10.0,
                        ), // Blur effect
                        child: Container(
                          width: 50, // Width of the rectangle
                          height: 50, // Height of the rectangle
                          decoration: BoxDecoration(
                            color: darkColor.withOpacity(
                                0.5), // Darker color for the rectangle
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Circle child in the middle
              Positioned.fill(
                child: Center(
                  child: ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 3.0, // Blur effect for the circle
                        sigmaY: 3.0,
                      ),
                      child: Container(
                        width: 30, // Width of the inner circle
                        height: 30, // Height of the inner circle
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              circleColor.withOpacity(0.8),
                              circleColor.withOpacity(0.0),
                            ],
                            stops: [
                              0.5,
                              1.0
                            ], // Adjust the stops for the gradient
                          ),
                          shape: BoxShape.circle, // Make it a circle
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 4,
                              spreadRadius: 2,
                              offset: Offset(2, 2), // Shadow position
                            ),
                          ],
                          border: Border.all(
                            color: Colors.white, // Border color
                            width: 2, // Border width
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Text(
          genre.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
