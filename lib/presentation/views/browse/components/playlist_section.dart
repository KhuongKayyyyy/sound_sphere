import 'package:flutter/material.dart';
import 'playlist_item.dart';

class PlaylistSection extends StatelessWidget {
  final List<String> imageList;
  final bool isBig;

  const PlaylistSection({
    required this.imageList,
    required this.isBig,
    Key? key,
  }) : super(key: key);

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
            child: PlaylistItem(img: imageList[index], isBig: isBig),
          );
        },
      ),
    );
  }
}
