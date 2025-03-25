import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';

class FavoriteToast extends StatelessWidget {
  final bool isFavorite;
  const FavoriteToast({super.key, required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 130,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Row(
            children: [
              Icon(
                isFavorite
                    ? CupertinoIcons.heart_solid
                    : CupertinoIcons.heart_slash,
                color: AppColor.primaryColor,
                size: 24,
              ),
              const SizedBox(width: 10),
              Text(
                isFavorite ? "Favorite" : "Unfavorite",
                style: TextStyle(
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
