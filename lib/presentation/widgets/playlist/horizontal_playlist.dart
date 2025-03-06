import 'package:flutter/cupertino.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/data/models/playlist.dart';

class HorizontalPlaylist extends StatefulWidget {
  final Playlist playlist;
  const HorizontalPlaylist({super.key, required this.playlist});

  @override
  State<HorizontalPlaylist> createState() => _HorizontalPlaylistState();
}

class _HorizontalPlaylistState extends State<HorizontalPlaylist> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.playlist.imgURL!,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
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
    );
  }
}
