import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sound_sphere/core/constant/app_image.dart';

class ListenNowHeader extends StatelessWidget {
  const ListenNowHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Listen Now',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              formatTodayDate(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              AppImage.defaultEmojiAvatar,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  String formatTodayDate() {
    final now = DateTime.now();
    final daySuffix = _getDaySuffix(now.day);
    final formattedDate =
        '${DateFormat('EEEE, d').format(now)}$daySuffix of ${DateFormat('MMMM').format(now)}';
    return formattedDate;
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
