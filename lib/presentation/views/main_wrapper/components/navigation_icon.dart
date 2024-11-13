import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';

class NavigationIconWidget extends StatelessWidget {
  final dynamic icon;
  final String label;
  final int index;
  final Function(int) onTap;

  const NavigationIconWidget({
    Key? key,
    required this.icon,
    required this.label,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28),
          Text(label, style: TextStyle(color: AppColor.primaryColor)),
        ],
      ),
    );
  }
}
