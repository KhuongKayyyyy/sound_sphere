import 'package:flutter/material.dart';
import 'package:sound_sphere/core/controller/player_controller.dart';

// ignore: must_be_immutable
class NonSyncLyrics extends StatefulWidget {
  ScrollController lyricsScrollController;
  final PlayerController playerController = PlayerController();
  NonSyncLyrics({
    super.key,
    required this.lyricsScrollController,
  });

  @override
  State<NonSyncLyrics> createState() => _NonSyncLyricsState();
}

class _NonSyncLyricsState extends State<NonSyncLyrics> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.lyricsScrollController,
      child: SizedBox(
          width: double.infinity,
          child: AnimatedBuilder(
            animation: widget.playerController,
            builder: (context, builder) => Text(
              widget.playerController.getCurrentSong().lyrics,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontWeight: FontWeight.w900,
                  height: 1.5,
                  fontSize: 35),
            ),
          )),
    );
  }
}
