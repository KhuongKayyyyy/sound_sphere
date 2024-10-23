import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';

class MainPlayButton extends StatelessWidget {
  final VoidCallback? onPressed; // Add this parameter for the callback

  const MainPlayButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            width: 2,
            color: Colors.white,
          ),
        ),
        child: const Icon(
          Icons.play_arrow,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
