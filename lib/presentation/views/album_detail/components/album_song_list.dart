import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/song.dart';
import 'package:sound_sphere/core/constant/app_color.dart';

class AlbumSongList extends StatelessWidget {
  final List<Song> songs;

  const AlbumSongList({Key? key, required this.songs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Column(
            children: [
              ListTile(
                leading: Text("${index + 1}",
                    style: TextStyle(color: AppColor.primaryColor)),
                title: Text(songs[index].title),
                trailing: IconButton(
                    icon: const Icon(Icons.more_horiz), onPressed: () {}),
              ),
              Divider(color: Colors.black.withOpacity(0.2)),
            ],
          );
        },
        childCount: songs.length,
      ),
    );
  }
}
