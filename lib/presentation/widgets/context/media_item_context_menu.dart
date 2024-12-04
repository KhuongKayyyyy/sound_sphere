import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/data/models/album.dart';
import 'package:sound_sphere/data/models/track.dart';

class MediaItemContextMenu extends StatefulWidget {
  final Track? track;
  final Album? album;
  const MediaItemContextMenu({super.key, this.album, this.track});

  @override
  State<MediaItemContextMenu> createState() => _MediaItemContextMenuState();
}

class _MediaItemContextMenuState extends State<MediaItemContextMenu> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: widget.track?.imgURL ?? widget.album?.imgURL ?? '',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.track?.title ?? widget.album?.title ?? '',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              widget.track?.artist.name ?? widget.album?.aritst.name ?? '',
              style: TextStyle(
                  color: AppColor.inkGreyDark,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
