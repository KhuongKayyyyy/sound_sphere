import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';

class TrackBottomSheetButton extends StatelessWidget {
  final String buttonText;
  final bool isLiked;

  TrackBottomSheetButton({required this.buttonText, required this.isLiked});

  @override
  Widget build(BuildContext context) {
    // Determine the icon based on the button text
    IconData _getIcon() {
      switch (buttonText.toLowerCase()) {
        case 'like':
          return isLiked ? Icons.favorite : Icons.favorite_border;
        case 'share':
          return Icons.share;
        case 'download':
          return Icons.download;
        case 'view artist':
          return Icons.person;
        case 'about track':
          return Icons.info_outline_rounded;
        default:
          return Icons.help; // Default icon if the text doesn't match
      }
    }

    return InkWell(
      child: Container(
        height: 60,
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[100],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 10),
            Icon(
              _getIcon(),
              color: isLiked && buttonText.toLowerCase() == 'like'
                  ? AppColor.primaryColor
                  : Colors.black,
            ),
            const SizedBox(width: 8),
            Text(buttonText),
            const Spacer(),
          ],
        ),
      ),
      onTap: () {
        // Handle button press
      },
    );
  }
}
