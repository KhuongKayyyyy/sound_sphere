import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/controller/player_controller.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';

class CurrentSong extends StatefulWidget {
  final PlayerController playerController = PlayerController();
  bool isFavorite;
  bool _canShowSnackBar = true;
  CurrentSong({super.key, required this.isFavorite});

  @override
  State<CurrentSong> createState() => _CurrentSongState();
}

class _CurrentSongState extends State<CurrentSong> {
  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('songInfo'),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 90),
          child: Center(
            child: ValueListenableBuilder(
              valueListenable: widget.playerController.isPlayingNotifier,
              builder: (context, isPlaying, child) => AnimatedScale(
                scale: isPlaying ? 1.3 : 1.0,
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
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
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
                                'Go to Artist',
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
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        context.pushNamed(Routes.artistDetail,
                            extra: "artistId");
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
                  child: ValueListenableBuilder(
                    valueListenable:
                        widget.playerController.currentSongNotifier,
                    builder: (context, currentSong, child) => Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        boxShadow: isPlaying
                            ? [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                ),
                              ]
                            : [],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: Stack(
                          children: [
                            // Scaled image
                            SizedBox(
                              height: 250,
                              width: 250,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: AnimatedBuilder(
                                  animation: widget.playerController,
                                  builder: (context, child) {
                                    return Image.network(
                                      widget.playerController
                                          .getCurrentSong()
                                          .imgURL,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                            ),
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
                                    if (widget._canShowSnackBar) {
                                      setState(() {
                                        widget.isFavorite = !widget.isFavorite;
                                        _showFavoriteSnackBar();
                                        widget._canShowSnackBar = false;
                                      });
                                      Future.delayed(
                                          const Duration(seconds: 10), () {
                                        widget._canShowSnackBar = true;
                                      });
                                    } else {
                                      setState(() {
                                        widget.isFavorite = !widget.isFavorite;
                                      });
                                    }
                                  },
                                  icon: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    transitionBuilder: (Widget child,
                                        Animation<double> animation) {
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
            ),
          ),
        ),
        InkWell(
          onTap: () {
            _showPopupMenu();
          },
          child: Column(
            children: [
              AnimatedBuilder(
                animation: widget.playerController,
                builder: (context, child) => Text(
                  widget.playerController.getCurrentSong().title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              AnimatedBuilder(
                animation: widget.playerController,
                builder: (context, child) => Text(
                  widget.playerController.getCurrentSong().artistName,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
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
                  child: AnimatedBuilder(
                      animation: widget.playerController,
                      builder: (context, child) {
                        return Image.network(
                            widget.playerController.getCurrentSong().imgURL,
                            fit: BoxFit.cover);
                      }),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                    animation: widget.playerController,
                    builder: (context, child) {
                      return Text(
                          widget.playerController.getCurrentSong().title,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold));
                    }),
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
