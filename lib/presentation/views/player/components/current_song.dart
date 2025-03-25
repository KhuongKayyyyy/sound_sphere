import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/controller/player_controller.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/blocs/library/library_bloc.dart';
import 'package:sound_sphere/presentation/widgets/text/auto_scroll_text.dart';

// ignore: must_be_immutable
class CurrentSong extends StatefulWidget {
  final PlayerController playerController = PlayerController();
  // bool _canShowSnackBar = true;
  bool isFavorite;
  CurrentSong({super.key, required this.isFavorite});

  @override
  State<CurrentSong> createState() => _CurrentSongState();
}

class _CurrentSongState extends State<CurrentSong> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LibraryBloc, LibraryState>(
      listener: (context, state) {
        if (state is ToggleTrackFavoriteSuccess) {
          setState(() {
            // widget.isFavorite = state.isFavorite;
            widget.isFavorite = !widget.isFavorite;
            if (state.isFavorite) {
              _showFavoriteSnackBar();
            }
          });
        }
      },
      child: Column(
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
                          context.pushNamed(Routes.albumDetail,
                              extra: "albumId");
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
                                Text(FakeData.artists.first.name!,
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
                          child:
                              // Scaled image
                              SizedBox(
                            height: 250,
                            width: 250,
                            child: Hero(
                              tag: "currentSongImage",
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
                          ),
                          // Favorite button
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Ensures left and right alignment
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Aligns content vertically
                  children: [
                    // Left Side: Song title and artist name
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Song Title with AutoScrollingText if it overflows
                          AnimatedBuilder(
                            animation: widget.playerController,
                            builder: (context, child) {
                              final text =
                                  widget.playerController.currentSong.title;
                              final textStyle = const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              );
                              final textPainter = TextPainter(
                                text: TextSpan(text: text, style: textStyle),
                                maxLines: 1,
                                textDirection: TextDirection.ltr,
                              )..layout(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.75,
                                );

                              return textPainter.didExceedMaxLines
                                  ? AutoScrollingText(
                                      text: text,
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      textStyle: textStyle,
                                    )
                                  : Text(
                                      text,
                                      style: textStyle,
                                      overflow: TextOverflow.ellipsis,
                                    );
                            },
                          ),
                          const SizedBox(height: 10),
                          // Artist Name
                          AnimatedBuilder(
                            animation: widget.playerController,
                            builder: (context, child) => Text(
                              widget.playerController
                                  .getCurrentSong()
                                  .artist
                                  .name!,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Right Side: Buttons
                    Row(
                      children: [
                        // Favorite Button
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.7),
                          ),
                          child: InkWell(
                            onTap: () {
                              context.read<LibraryBloc>().add(
                                  ToggleTrackFavorite(
                                      track: widget.playerController
                                          .getCurrentSong(),
                                      isFavorite: !widget.isFavorite));
                            },
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return ScaleTransition(
                                  scale: animation,
                                  alignment: Alignment.center,
                                  child: child,
                                );
                              },
                              child: widget.isFavorite
                                  ? Icon(
                                      Icons.favorite,
                                      size: 25,
                                      color: AppColor.primaryColor,
                                      key: const ValueKey('favorite'),
                                    )
                                  : const Icon(
                                      size: 25,
                                      Icons.favorite_outline_rounded,
                                      color: Colors.white,
                                      key: ValueKey('not_favorite'),
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // More Button
                        InkWell(
                          onTap: () => context.pop(),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.7),
                            ),
                            child: const Icon(
                              Icons.more_horiz_rounded,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ],
      ),
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
                      final text = widget.playerController.currentSong.title;
                      final textStyle = TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      );
                      final textPainter = TextPainter(
                        text: TextSpan(text: text, style: textStyle),
                        maxLines: 1,
                        textDirection: TextDirection.ltr,
                      )..layout(
                          maxWidth: MediaQuery.of(context).size.width * 0.3);

                      return textPainter.didExceedMaxLines
                          ? AutoScrollingText(
                              text: text,
                              width: MediaQuery.of(context).size.width * 0.3,
                              textStyle: textStyle,
                            )
                          : Text(
                              text,
                              style: textStyle,
                            );
                    }),
                Text("Loved",
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold,
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
          bottom: MediaQuery.of(context).size.height * 0.73,
          right: 60,
          left: 60),
      elevation: 0,
    ));
  }

  void _showPopupMenu() {}
}
