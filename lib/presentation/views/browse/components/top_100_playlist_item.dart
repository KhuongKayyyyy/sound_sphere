import 'dart:math';
import 'package:flutter/material.dart';

class Top100PlaylistItem extends StatelessWidget {
  final Color backgroundColor = const Color.fromRGBO(247, 243, 234, 1);
  final String location;

  const Top100PlaylistItem({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    // Generate a random color for the location text, which will be reused in the gradient for "1"
    final Color locationColor = _randomColor();
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 5),
                  blurRadius: 20,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "TOP 100",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.grey[350]),
                        ),
                        Text(
                          location,
                          maxLines: 2,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: locationColor,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      "SoundSphere",
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[400]),
                    ),
                  ],
                ),
                const SizedBox(height: 19),
                // Scale and Gradient Effect
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Glow/Shadow effect around the text
                    Text(
                      "100",
                      style: TextStyle(
                        fontSize: 80, // Original font size
                        fontWeight: FontWeight.w900,
                        shadows: [
                          Shadow(
                            blurRadius: 15,
                            color: locationColor.withOpacity(0.5),
                            offset: const Offset(4, 2),
                          ),
                          Shadow(
                            blurRadius: 25,
                            color: Colors.white.withOpacity(0.7),
                            offset: const Offset(4, 2),
                          ),
                        ],
                        color: Colors
                            .transparent, // For overlaying with ShaderMask
                      ),
                    ),
                    // Gradient overlay
                    ShaderMask(
                      shaderCallback: (bounds) {
                        return LinearGradient(
                          colors: [
                            locationColor,
                            _randomColor(),
                            _randomColor(),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds);
                      },
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "1",
                              style: TextStyle(
                                fontSize: 80,
                                fontWeight: FontWeight.w900,
                                color: Colors.white, // Will be overridden
                              ),
                            ),
                            TextSpan(
                              text: "00",
                              style: TextStyle(
                                fontSize: 80,
                                fontWeight: FontWeight.w900,
                                color: Colors.white, // Will be overridden
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Top 100 $location",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.grey[800],
            ),
          ),
          Text(
            "SoundSphere",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Color _randomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256), // Random red
      random.nextInt(256), // Random green
      random.nextInt(256), // Random blue
    );
  }
}
