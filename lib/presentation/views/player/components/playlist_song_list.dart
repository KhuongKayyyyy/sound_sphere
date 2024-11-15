import 'package:flutter/material.dart';
import 'package:sound_sphere/core/controller/player_controller.dart';
import 'package:sound_sphere/data/models/song.dart';

// ignore: must_be_immutable
class PlaylistSonglist extends StatefulWidget {
  PlayerController playerController = PlayerController();
  List<Song> songList;
  bool isInfinitePlaylist;
  ScrollController? scrollController;
  PlaylistSonglist(
      {super.key,
      required this.songList,
      this.scrollController,
      required this.isInfinitePlaylist});

  @override
  State<PlaylistSonglist> createState() => _PlaylistSonglistState();
}

class _PlaylistSonglistState extends State<PlaylistSonglist> {
  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      scrollController: widget.scrollController,
      proxyDecorator: (Widget child, int index, Animation<double> animation) {
        return Material(
          color: Colors.black.withOpacity(0.2),
          child: child,
        );
      },
      onReorder: onReorder,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      buildDefaultDragHandles: false,
      children: [
        for (var song in widget.songList)
          Dismissible(
            key: ValueKey(song.title),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              removeSong(song);
            },
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.red,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Row(
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          song.imgURL,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          song.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          song.artistName,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    ReorderableDragStartListener(
                      index: widget.songList.indexOf(song),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.menu,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  void onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final song = widget.songList.removeAt(oldIndex);
      widget.songList.insert(newIndex, song);
      if (!widget.isInfinitePlaylist) {
        PlayerController().setPlayerAudio(widget.songList);
      }
    });
  }

  void removeSong(Song song) {
    setState(() {
      widget.songList.remove(song);
    });
    if (!widget.isInfinitePlaylist) {
      PlayerController().setPlayerAudio(widget.songList);
    }
  }
}
