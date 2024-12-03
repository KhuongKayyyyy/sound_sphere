import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/data/models/album.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:go_router/go_router.dart';

class MediaItem extends StatefulWidget {
  final Track? track;
  final Album? album;

  const MediaItem({super.key, this.track, this.album});

  @override
  State<MediaItem> createState() => _MediaItemState();
}

class _MediaItemState extends State<MediaItem> {
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
        CupertinoContextMenuAction(
          trailingIcon: CupertinoIcons.share,
          child: const Text('Share song'),
          onPressed: () {
            context.pushNamed(Routes.songDetail, extra: "songId");
          },
        ),
      ],
      builder: (BuildContext context, Animation<double> animation) {
        final bool isMenuOpen = animation.value > 0;
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.4,
          ),
          child: _buildMediaItem(isMenuOpen, animation, context),
        );
      },
    );
  }

  Widget _buildMediaItem(
      bool isMenuOpen, Animation<double> animation, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isMenuOpen) const SizedBox(height: 20),
          ScaleTransition(
            scale: Tween<double>(begin: 1.0, end: 1.8).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(5),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    context.pushNamed(Routes.songDetail,
                        extra: widget.track?.id ?? widget.album?.id);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          imageUrl: widget.track?.imgURL ??
                              widget.album?.imgURL ??
                              '',
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height * 0.19,
                          width: MediaQuery.of(context).size.width * 0.42,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.track?.title ?? widget.album?.title ?? '',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.track?.artist.name ??
                            widget.album?.aritst.name ??
                            '',
                        style: TextStyle(
                          color: AppColor.inkGreyDark,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isMenuOpen) const SizedBox(height: 80),
        ],
      ),
    );
  }
}
