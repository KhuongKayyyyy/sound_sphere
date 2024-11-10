import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';

class AppBarButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final bool isActive;

  const AppBarButton({
    required this.onPressed,
    required this.title,
    required this.isActive,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        height: 30,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: isActive ? AppColor.primaryColor : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
