import 'package:flutter/material.dart';
import 'package:sound_sphere/core/controller/player_controller.dart';
import 'package:sound_sphere/data/models/song.dart';

// ignore: must_be_immutable
class InfinitePlaylistSongList extends StatefulWidget {
  PlayerController playerController = PlayerController();
  ScrollController? scrollController;

  InfinitePlaylistSongList({
    super.key,
    required this.scrollController,
    required List<Song> songList,
  });

  @override
  State<InfinitePlaylistSongList> createState() =>
      _InfinitePlaylistSongListState();
}

class _InfinitePlaylistSongListState extends State<InfinitePlaylistSongList> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Song>>(
      valueListenable: widget.playerController.infiniteSongsNotifier,
      builder: (context, songList, child) {
        return Column(
          children: [
            ReorderableListView(
              scrollController: widget.scrollController,
              proxyDecorator:
                  (Widget child, int index, Animation<double> animation) {
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
                // Only show songs after the current index
                for (var i = 0 + 1; i < songList.length; i++)
                  Dismissible(
                    key: ValueKey(songList[i].title),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      removeSong(songList[i]);
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
                    child: InkWell(
                      onTap: () {
                        widget.playerController.jumpToSong(i);
                      },
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 60,
                                width: 60,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    songList[i].imgURL,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    songList[i].title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    songList[i].artistName,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.5),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              ReorderableDragStartListener(
                                index: i,
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
                  ),
              ],
            ),
          ],
        );
      },
    );
  }

  void onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final song = widget.playerController.infiniteSongsNotifier.value
          .removeAt(oldIndex);
      widget.playerController.infiniteSongsNotifier.value
          .insert(newIndex, song);
      widget.playerController.updateInfiniteSongs(
          widget.playerController.infiniteSongsNotifier.value);
    });
  }

  void removeSong(Song song) {
    widget.playerController.removeSongFromInfinite(song);
  }
}
