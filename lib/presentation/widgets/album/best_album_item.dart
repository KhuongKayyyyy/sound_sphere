import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/album.dart';

class BestAlbumItem extends StatelessWidget {
  VoidCallback? onPressed;
  final Color backgroundColor = const Color(0xffb9fade);
  final Album album;

  BestAlbumItem({super.key, required this.album, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.apple, size: 30),
                  SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      "Music",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
              const Text(
                "100 Best",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
              const Text(
                "Albums",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
              Center(
                child: SizedBox(
                  height: 270,
                  child: Stack(
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            imageUrl: album.imgURL,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.1),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              )),
                          child: const Text(
                            "A landmark that did nothing but redefine the scope and reach of pop",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 3.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ],
                            ),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
