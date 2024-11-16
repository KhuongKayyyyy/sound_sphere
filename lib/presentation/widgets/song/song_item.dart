import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/data/models/song.dart';
import 'package:go_router/go_router.dart';

class SongItem extends StatelessWidget {
  final Song song;

  const SongItem({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return CupertinoContextMenu.builder(
      actions: [
        CupertinoContextMenuAction(
          onPressed: () {
            context.pushNamed(Routes.songDetail, extra: "songId");
          },
          trailingIcon: CupertinoIcons.play_arrow,
          child: const Text('Play'),
        ),
        const Divider(
          color: Colors.transparent,
        ),
        CupertinoContextMenuAction(
          trailingIcon: CupertinoIcons.add,
          child: const Text('Add to Playlist'),
          onPressed: () {
            context.pushNamed(Routes.songDetail, extra: "songId");
          },
        ),
        CupertinoContextMenuAction(
          trailingIcon: CupertinoIcons.list_bullet_below_rectangle,
          child: const Text('Add to Library'),
          onPressed: () {
            context.pushNamed(Routes.songDetail, extra: "songId");
          },
        ),
        const Divider(
          color: Colors.transparent,
        ),
        CupertinoContextMenuAction(
          trailingIcon: CupertinoIcons.star,
          child: const Text('Add to Favorite'),
          onPressed: () {
            context.pushNamed(Routes.songDetail, extra: "songId");
          },
        ),
        CupertinoContextMenuAction(
          trailingIcon: CupertinoIcons.hand_thumbsdown,
          child: const Text('Suggest less'),
          onPressed: () {
            context.pushNamed(Routes.songDetail, extra: "songId");
          },
        ),
        const Divider(
          color: Colors.transparent,
        ),
        CupertinoContextMenuAction(
          trailingIcon: CupertinoIcons.share,
          child: const Text('Share song'),
          onPressed: () {
            context.pushNamed(Routes.songDetail, extra: "songId");
          },
        ),
      ],
      builder: (BuildContext context, Animation<double> animation) {
        // Determine if the context menu is open
        final bool isMenuOpen = animation.value > 0;

        return Column(
          mainAxisSize: MainAxisSize.min, // Add this line to prevent overflow
          children: [
            if (isMenuOpen) const SizedBox(height: 80),
            ScaleTransition(
              scale: Tween<double>(begin: 1.0, end: 1.8).animate(
                // Adjusted scaling factor
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                ),
              ),
              child: Container(
                height: 200,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(5),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      context.pushNamed(Routes.songDetail, extra: "songId");
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              imageUrl: song.imgURL,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          song.title,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          song.artistName,
                          style: TextStyle(
                            color: AppColor.inkGreyDark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (isMenuOpen) const SizedBox(height: 80),
          ],
        );
      },
    );
  }
}
