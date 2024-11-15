import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/controller/player_controller.dart';
import 'package:sound_sphere/presentation/widgets/text/auto_scroll_text.dart';

// ignore: must_be_immutable
class PlaylistFunction extends StatefulWidget {
  VoidCallback onInfinity;
  VoidCallback onShuffle;
  bool showHistory;
  VoidCallback onShowHistory;
  final PlayerController playerController = PlayerController();

  PlaylistFunction(
      {super.key,
      required this.onInfinity,
      required this.onShuffle,
      required this.showHistory,
      required this.onShowHistory});

  @override
  State<PlaylistFunction> createState() => _PlaylistFunctionState();
}

class _PlaylistFunctionState extends State<PlaylistFunction> {
  // bool _isShuffle = PlayerController().isShuffle;
  bool _isRepeat = PlayerController().isRepeat;
  final bool _isLoop = PlayerController().isLoop;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 700),
          firstChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "History",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  "Clear history",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          secondChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Playing next",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
              AnimatedBuilder(
                animation: widget.playerController,
                builder: (context, child) {
                  final text =
                      "From ${widget.playerController.currentSong.artistName}";
                  final textStyle = TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  );
                  final textPainter = TextPainter(
                    text: TextSpan(text: text, style: textStyle),
                    maxLines: 1,
                    textDirection: TextDirection.ltr,
                  )..layout(maxWidth: 180);

                  return textPainter.didExceedMaxLines
                      ? AutoScrollingText(
                          text: text,
                          width: 180,
                          textStyle: textStyle,
                        )
                      : Text(
                          text,
                          style: textStyle,
                        );
                },
              ),
            ],
          ),
          crossFadeState: widget.showHistory
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
        ),
        const Spacer(),
        // Shuffle, Repeat, Infinity
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 700),
          child: widget.showHistory
              ? Row(
                  key: const ValueKey('controls'),
                  children: [
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
                  ],
                )
              : Container(
                  key: const ValueKey('empty'),
                ),
        ),
        InkWell(
          onTap: () {
            widget.onShowHistory();
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: !widget.showHistory
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(0.7),
                  )
                : null,
            child: Image.asset(
              AppIcon.history,
              scale: 20,
              color: widget.showHistory ? Colors.white : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
