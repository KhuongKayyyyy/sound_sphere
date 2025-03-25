import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/album.dart';
import 'package:sound_sphere/data/models/track.dart';

// ignore: must_be_immutable
class LibraryItem extends StatelessWidget {
  bool? isFavorite;
  Album? album;
  Track? track;
  Function()? onTap;
  LibraryItem({super.key, this.album, this.track, this.onTap, this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 170,
            width: 170,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]),
            child: Hero(
              tag: "lib_img_${track!.id}",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  track?.imgURL ?? album?.imgURL ?? '',
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return Center(
                      child: Icon(Icons.error, color: Colors.red, size: 40),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            track?.title ?? album?.title ?? '',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            overflow: TextOverflow.ellipsis,
            track?.artist.name ?? album?.aritst.name ?? '',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
