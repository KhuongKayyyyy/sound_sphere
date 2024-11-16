import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/controller/player_controller.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/presentation/views/player/player_page.dart';

class MusicPlayerWidget extends StatelessWidget {
  final Animation<double> scaleAnimation;
  final VoidCallback playMusic;
  final bool isPlaying;
  final PlayerController playerController;

  const MusicPlayerWidget(
      {super.key,
      required this.scaleAnimation,
      required this.playMusic,
      required this.isPlaying,
      required this.playerController});

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
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
                onTap: () => showBottomSheetWidget(context),
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: AnimatedBuilder(
                            animation: playerController,
                            builder: (context, child) {
                              return Hero(
                                tag: "songImage",
                                child: Image.network(
                                  playerController.getCurrentSong().imgURL,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Mini player text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedBuilder(
                            animation: playerController,
                            builder: (context, child) {
                              return Text(
                                playerController.getCurrentSong().title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }),
                        AnimatedBuilder(
                            animation: playerController,
                            builder: (context, child) {
                              return Text(
                                playerController.getCurrentSong().artistName,
                                style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Mini player buttons
            InkWell(
              onTap: () {
                playMusic();
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
                child: !isPlaying
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
                playerController.moveToNextSong();
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
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext builder) {
        return CupertinoPopupSurface(child: PlayerPage());
      },
    );
  }
}
