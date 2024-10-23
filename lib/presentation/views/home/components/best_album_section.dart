import 'package:flutter/material.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/widgets/album/best_album_item.dart';

class BestAlbumSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Featured in 100 Best Albums",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        BestAlbumItem(
          album: FakeData.albums.first,
        )
      ],
    );
  }
}
