import 'package:flutter/material.dart';
import 'playlist_item.dart';

class PlaylistSection extends StatelessWidget {
  final List<String> imageList;
  final bool isBig;
  static final List<String> title = [
    "Christmas Hits",
    "Happy new year!",
    "Best of 2024"
  ];
  static final List<String> subtitle = [
    "Sound",
    "Happy new year!",
    "Best of 2024"
  ];
  const PlaylistSection({
    required this.imageList,
    required this.isBig,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: index == imageList.length - 1
                ? const EdgeInsets.symmetric(horizontal: 20)
                : const EdgeInsets.only(left: 20),
            child: PlaylistItem(
                img: imageList[index],
                isBig: isBig,
                title: title[index],
                subtitle: subtitle[index]),
          );
        },
      ),
    );
  }
}
