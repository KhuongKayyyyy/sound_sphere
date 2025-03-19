import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_image.dart';
import 'package:sound_sphere/data/models/playlist.dart';

class HorizontalPlaylistItem extends StatefulWidget {
  final Function onPressed;
  final Playlist playlist;
  const HorizontalPlaylistItem(
      {super.key, required this.playlist, required this.onPressed});

  @override
  State<HorizontalPlaylistItem> createState() => _HorizontalPlaylistItemState();
}

class _HorizontalPlaylistItemState extends State<HorizontalPlaylistItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPressed();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            if (widget.playlist.imgURL != null)
              SizedBox(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    widget.playlist.imgURL!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        AppImage.logo, // Replace with your app logo asset path
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              )
            else
              Hero(
                tag: widget.playlist.id!,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColor.primaryColor,
                        AppColor.secondaryColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(
                      CupertinoIcons.music_note_list,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.playlist.name!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Sound Sphere Hip Hop",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.inkGreyDark),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              CupertinoIcons.chevron_right,
              color: AppColor.inkGreyDark,
            ),
          ],
        ),
      ),
    );
  }
}
