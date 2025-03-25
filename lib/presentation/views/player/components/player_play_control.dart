import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/controller/player_controller.dart';
import 'package:sound_sphere/presentation/blocs/library/library_bloc.dart';

class PlayerPlayControl extends StatefulWidget {
  final PlayerController playerController = PlayerController();
  PlayerPlayControl({super.key});

  @override
  State<PlayerPlayControl> createState() => _PlayerPlayControlState();
}

class _PlayerPlayControlState extends State<PlayerPlayControl> {
  void _togglePlayPause() {
    if (widget.playerController.isPlaying) {
      widget.playerController.pause();
    } else {
      widget.playerController.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  // context.read<LibraryBloc>().add(CheckIfTrackIsFavorite(
                  //     widget.playerController.currentSong.id!));
                  widget.playerController.moveToPreviousSong();
                },
                child: Image.asset(
                  AppIcon.play_previous,
                  scale: 15,
                  color: Colors.white,
                ),
              ),
              InkWell(
                  onTap: () {
                    _togglePlayPause();
                  },
                  child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: ValueListenableBuilder<bool>(
                        valueListenable:
                            widget.playerController.isPlayingNotifier,
                        builder: (context, isPlaying, child) {
                          return InkWell(
                            onTap: () {
                              _togglePlayPause();
                            },
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return ScaleTransition(
                                    scale: animation, child: child);
                              },
                              child: !isPlaying
                                  ? Image.asset(
                                      AppIcon.play,
                                      key: const ValueKey('play'),
                                      scale: 15,
                                      color: Colors.white,
                                    )
                                  : Image.asset(
                                      AppIcon.pause,
                                      key: const ValueKey('pause'),
                                      scale: 15,
                                      color: Colors.white,
                                    ),
                            ),
                          );
                        },
                      ))),
              InkWell(
                onTap: () {
                  // setState(() {
                  //   _moveToNextSong();
                  // });
                  // context.read<LibraryBloc>().add(CheckIfTrackIsFavorite(
                  //     widget.playerController.currentSong.id!));
                  widget.playerController.moveToNextSong();
                  setState(() {});
                },
                child: Image.asset(
                  AppIcon.play_next,
                  scale: 15,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
