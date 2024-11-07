import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/song.dart';

class SongInfo extends StatefulWidget {
  Song currentSong;
  bool isPlaying = false;
  bool isFavorite = true;
  SongInfo(
      {super.key,
      required this.currentSong,
      required this.isPlaying,
      required this.isFavorite});

  @override
  State<SongInfo> createState() => _SongInfoState();
}

class _SongInfoState extends State<SongInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('songInfo'),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 70),
          child: Center(
            child: AnimatedScale(
              scale: widget.isPlaying ? 1.3 : 1.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: CupertinoContextMenu(
                actions: [
                  CupertinoContextMenuAction(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Go to Album',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(FakeData.albums[0].title,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const Spacer(),
                        Image.asset(
                          AppIcon.stack,
                          scale: 20,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      context.pushNamed(Routes.albumDetail, extra: "albumId");
                    },
                  ),
                  CupertinoContextMenuAction(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Go to Aritst',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(FakeData.artists.first.name,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const Spacer(),
                        Image.asset(
                          AppIcon.micro,
                          scale: 20,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      // Navigator.of(context).pop();
                      context.pushNamed(Routes.artistDetail, extra: "artistId");
                    },
                  ),
                  CupertinoContextMenuAction(
                    child: const Text(
                      'Share',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {},
                  ),
                ],
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    boxShadow: widget.isPlaying
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 5,
                            ),
                          ]
                        : [],
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(widget.currentSong.imgURL),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Favorite button
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.7),
                          ),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                widget.isFavorite = !widget.isFavorite;
                                _showFavoriteSnackBar();
                              });
                            },
                            icon: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return ScaleTransition(
                                    scale: animation, child: child);
                              },
                              child: widget.isFavorite
                                  ? Icon(
                                      Icons.favorite,
                                      color: AppColor.primaryColor,
                                      key: const ValueKey('favorite'),
                                    )
                                  : const Icon(
                                      Icons.favorite_outline_rounded,
                                      color: Colors.white,
                                      key: ValueKey('not_favorite'),
                                    ),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      // More button
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: CupertinoContextMenu(
                          actions: [
                            CupertinoContextMenuAction(
                              child: const Text('Add to playlist'),
                              onPressed: () {},
                            ),
                            CupertinoContextMenuAction(
                              child: const Text('Share'),
                              onPressed: () {},
                            ),
                          ],
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.7),
                            ),
                            child: const Icon(
                              Icons.more_horiz_rounded,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        // song name and artist name
        InkWell(
          onTap: () {
            _showPopupMenu();
          },
          child: Column(
            children: [
              Text(
                widget.currentSong.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.currentSong.artistName,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showFavoriteSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ]),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child:
                    Image.network(widget.currentSong.imgURL, fit: BoxFit.cover),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.currentSong.title,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                Text("Loved",
                    style: TextStyle(
                      color: AppColor.primaryColor,
                    ))
              ],
            ),
            Icon(Icons.favorite, color: AppColor.primaryColor),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 200,
          right: 60,
          left: 60),
      elevation: 0,
    ));
  }

  void _showPopupMenu() {}
}
