import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';

// ignore: must_be_immutable
class ShufflePlayButton extends StatefulWidget {
  VoidCallback? onPressed;
  Color? color;
  ShufflePlayButton({super.key, this.onPressed});

  @override
  State<ShufflePlayButton> createState() => _ShufflePlayButtonState();
}

class _ShufflePlayButtonState extends State<ShufflePlayButton> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
          decoration: BoxDecoration(
            color: AppColor.secondaryColor
                .withOpacity(0.2), // Adjust opacity for glass effect
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: widget.color ??
                  Colors.white.withOpacity(
                      0.2), // Optional: add a light border for more effect
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                height: 25,
                width: 25,
                child: Image.asset(
                  AppIcon.play,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "Shuffle",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
