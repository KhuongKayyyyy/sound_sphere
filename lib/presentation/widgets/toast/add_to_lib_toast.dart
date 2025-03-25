import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';

class AddToLibToast extends StatelessWidget {
  const AddToLibToast({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 180,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Row(
            children: [
              Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: AppColor.primaryColor,
                size: 24,
              ),
              const SizedBox(width: 10),
              Text(
                "Added to library",
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
