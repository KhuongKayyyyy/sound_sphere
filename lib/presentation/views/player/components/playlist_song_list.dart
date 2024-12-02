import 'package:flutter/material.dart';
import 'package:sound_sphere/core/controller/player_controller.dart';
import 'package:sound_sphere/data/models/track.dart';

// ignore: must_be_immutable
class PlaylistSonglist extends StatefulWidget {
  // List<Song> songList;
  ScrollController? scrollController;

  PlaylistSonglist({
    super.key,
    // required this.songList,
    this.scrollController,
  });

  @override
  State<PlaylistSonglist> createState() => _PlaylistSonglistState();
}

class _PlaylistSonglistState extends State<PlaylistSonglist> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: PlayerController(),
          builder: (context, child) => ReorderableListView(
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
              for (var i = PlayerController().currentSongIndex;
                  i < PlayerController().playlistSongs.length;
                  i++)
                Dismissible(
                  key: ValueKey(PlayerController().playlistSongs[i]),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    PlayerController()
                        .removeSong(PlayerController().playlistSongs[i]);
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
                      PlayerController().jumpToSong(i);
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
                                  PlayerController().playlistSongs[i].imgURL,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  PlayerController().playlistSongs[i].title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  PlayerController()
                                      .playlistSongs[i]
                                      .artist
                                      .name!,
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
        ),
      ],
    );
  }

  void onReorder(int oldIndex, int newIndex) async {
    // await PlayerController().updatePlaylistOrder(oldIndex, newIndex);
    setState(() {
      // if (oldIndex + 1 < newIndex + 1) {
      //   newIndex -= 1;
      // }
      // final item = PlayerController().playlistSongs.removeAt(oldIndex + 1);
      // PlayerController().playlistSongs.insert(newIndex + 1, item);
      // PlayerController().updateAudioSource();
      PlayerController().updatePlaylistOrder(oldIndex, newIndex);
    });
  }

  void removeSong(Track song) {
    setState(() {
      // widget.songList.remove(song);
      PlayerController().playlistSongs.remove(song);
    });
  }
}
