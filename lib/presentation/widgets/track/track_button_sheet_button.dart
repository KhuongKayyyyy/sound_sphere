import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';

class TrackBottomSheetButton extends StatefulWidget {
  final String buttonText;
  final bool isLiked;
  final Function()? onPressed;

  const TrackBottomSheetButton(
      {super.key,
      required this.buttonText,
      required this.isLiked,
      this.onPressed});

  @override
  State<TrackBottomSheetButton> createState() => _TrackBottomSheetButtonState();
}

class _TrackBottomSheetButtonState extends State<TrackBottomSheetButton> {
  @override
  Widget build(BuildContext context) {
    // Determine the icon based on the button text
    IconData getIcon() {
      switch (widget.buttonText.toLowerCase()) {
        case 'favorite' || 'favorited':
          return widget.isLiked ? Icons.favorite : Icons.favorite_border;
        case 'share':
          return CupertinoIcons.share;
        case 'download':
          return CupertinoIcons.cloud_download;
        case 'view artist':
          return CupertinoIcons.person;
        case 'about track':
          return Icons.info_outline_rounded;
        case 'add to playlist':
          return Icons.playlist_add;
        default:
          return CupertinoIcons.info; // Default icon if the text doesn't match
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
              getIcon(),
              color: widget.isLiked &&
                      widget.buttonText.toLowerCase() == 'favorited'
                  ? AppColor.primaryColor
                  : Colors.black,
            ),
            const SizedBox(width: 8),
            Text(widget.buttonText),
            const Spacer(),
          ],
        ),
      ),
      onTap: () {
        // Handle button press
        widget.onPressed?.call();
      },
    );
  }
}
