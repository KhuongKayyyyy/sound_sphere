import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/data/models/album.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/presentation/widgets/context/media_item_context_menu.dart';

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
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.9,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CupertinoContextMenu.builder(
          builder: (context, animation) {
            if (animation.value < CupertinoContextMenu.animationOpensAt) {
              return _buildMediaItem(context);
            }
            return widget.track != null
                ? MediaItemContextMenu(track: widget.track!)
                : MediaItemContextMenu(album: widget.album!);
          },
          actions: [
            CupertinoContextMenuAction(
              child: const Text('Play'),
              onPressed: () {
                Navigator.pop(context);
                context.pushNamed(
                  Routes.songDetail,
                  extra: widget.track?.id ?? widget.album?.id,
                );
              },
            ),
            CupertinoContextMenuAction(
              child: const Text('Add to Playlist'),
              onPressed: () {
                Navigator.pop(context);
                context.pushNamed(
                  Routes.songDetail,
                  extra: widget.track?.id ?? widget.album?.id,
                );
              },
            ),
            CupertinoContextMenuAction(
              child: const Text('Share'),
              onPressed: () {
                Navigator.pop(context);
                context.pushNamed(
                  Routes.songDetail,
                  extra: widget.track?.id ?? widget.album?.id,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaItem(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          context.pushNamed(
            Routes.songDetail,
            extra: widget.track?.id ?? widget.album?.id,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: widget.track?.imgURL ?? widget.album?.imgURL ?? '',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.19,
                width: MediaQuery.of(context).size.width * 0.42,
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.42,
              child: Text(
                widget.track?.title ?? widget.album?.title ?? '',
                style: const TextStyle(fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              widget.track?.artist.name ?? widget.album?.aritst.name ?? '',
              style: TextStyle(
                color: AppColor.inkGreyDark,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
