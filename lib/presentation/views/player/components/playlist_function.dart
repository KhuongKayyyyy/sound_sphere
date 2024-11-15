import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/controller/player_controller.dart';

// ignore: must_be_immutable
class PlaylistFunction extends StatefulWidget {
  VoidCallback onInfinity;
  VoidCallback onShuffle;
  final PlayerController playerController = PlayerController();

  PlaylistFunction(
      {super.key, required this.onInfinity, required this.onShuffle});

  @override
  State<PlaylistFunction> createState() => _PlaylistFunctionState();
}

class _PlaylistFunctionState extends State<PlaylistFunction> {
  // bool _isShuffle = PlayerController().isShuffle;
  bool _isRepeat = PlayerController().isRepeat;
  final bool _isLoop = PlayerController().isLoop;
  bool _showHistory = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Playing next",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 20)),
            Text("From ${widget.playerController.currentSong.artistName}",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
          ],
        ),
        const Spacer(),
        // Shuffle, Repeat, Infinity
        InkWell(
          onTap: () => widget.onShuffle(),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: PlayerController().isShuffle
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(0.7),
                  )
                : null,
            child: Image.asset(
              AppIcon.shuffle,
              scale: 20,
              color: !PlayerController().isShuffle
                  ? Colors.white
                  : Colors.black.withOpacity(0.4),
            ),
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () => setState(() {
            _isRepeat = !_isRepeat;
          }),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: _isRepeat || _isLoop
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(0.7),
                  )
                : null,
            child: !_isRepeat
                ? Image.asset(
                    AppIcon.repeat,
                    scale: 20,
                    color: Colors.white,
                  )
                : Image.asset(
                    AppIcon.repeat_once,
                    scale: 20,
                    color: Colors.white,
                  ),
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () => widget.onInfinity(),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: PlayerController().isInfinity
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(0.7),
                  )
                : null,
            child: Image.asset(
              AppIcon.infinity,
              scale: 20,
              color: !PlayerController().isInfinity
                  ? Colors.white
                  : Colors.black.withOpacity(0.4),
            ),
          ),
        ),
        // InkWell(
        //   onTap: () {},
        //   child: Container(
        //     padding: const EdgeInsets.all(5),
        //     decoration: PlayerController().isInfinity
        //         ? BoxDecoration(
        //             borderRadius: BorderRadius.circular(10),
        //             color: Colors.white.withOpacity(0.7),
        //           )
        //         : null,
        //     child: Image.asset(
        //       AppIcon.infinity,
        //       scale: 20,
        //       color: !PlayerController().isInfinity
        //           ? Colors.white
        //           : Colors.black.withOpacity(0.4),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
