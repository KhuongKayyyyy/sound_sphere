import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/controller/player_controller.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/router/routes.dart';

import 'package:sound_sphere/presentation/views/player/player_page.dart';

class MusicPlayerWidget extends StatefulWidget {
  final VoidCallback playMusic;
  final bool isPlaying;
  final PlayerController playerController;

  const MusicPlayerWidget({
    super.key,
    required this.playMusic,
    required this.isPlaying,
    required this.playerController,
  });

  @override
  State<MusicPlayerWidget> createState() => _MusicPlayerWidgetState();
}

class _MusicPlayerWidgetState extends State<MusicPlayerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool isPlayerPageOpen = false;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Define the scale animation
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 3,
            ),
          ],
        ),
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Mini player song information
            Expanded(
              child: InkWell(
                onTap: () {
                  print(
                      GoRouter.of(context).routerDelegate.currentConfiguration);
                  context.pushNamed(Routes.player);
                },
                // onTap: () => showBottomSheetWidget(context),
                // onTap: () => Navigator.push(
                //   context,
                //   CupertinoPageRoute(builder: (context) => PlayerPage()),
                // ),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: Hero(
                        tag: 'currentSongImage',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: AnimatedBuilder(
                            animation: widget.playerController,
                            builder: (context, child) {
                              return Image.network(
                                widget.playerController.getCurrentSong().imgURL,
                                height: 40,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Mini player text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: widget.playerController,
                          builder: (context, child) {
                            return Text(
                              widget.playerController.getCurrentSong().title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                        AnimatedBuilder(
                          animation: widget.playerController,
                          builder: (context, child) {
                            return Text(
                              widget.playerController
                                  .getCurrentSong()
                                  .artistName,
                              style: TextStyle(
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Mini player buttons
            InkWell(
              onTap: () {
                widget.playMusic();
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 0.7, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOut,
                        ),
                      ),
                      child: child,
                    ),
                  );
                },
                child: !widget.isPlaying
                    ? Image.asset(
                        AppIcon.play,
                        height: 20,
                        key: const ValueKey('playIcon'),
                      )
                    : const Icon(
                        Icons.pause_rounded,
                        size: 30,
                        key: ValueKey('pauseIcon'),
                      ),
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () async {
                widget.playerController.moveToNextSong();
              },
              child: Image.asset(
                AppIcon.play_next,
                height: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showBottomSheetWidget(BuildContext context) {
    isPlayerPageOpen = true;
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext builder) {
        return CupertinoPopupSurface(child: PlayerPage());
      },
    ).then((value) {
      // This callback is triggered when the bottom sheet is closed.
      setState(() {
        isPlayerPageOpen = false;
        _triggerZoomAnimation();
      });
    });
  }

  void _triggerZoomAnimation() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
  }
}
