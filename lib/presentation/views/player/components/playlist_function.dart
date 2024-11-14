import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';

class PlaylistFunction extends StatefulWidget {
  const PlaylistFunction({super.key});

  @override
  State<PlaylistFunction> createState() => _PlaylistFunctionState();
}

class _PlaylistFunctionState extends State<PlaylistFunction> {
  bool _isShuffle = false;
  bool _isRepeat = false;
  final bool _isLoop = false;
  bool _isInfinity = false;
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
            Text("From SoundSphere",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
          ],
        ),
        const Spacer(),
        // Shuffle, Repeat, Infinity
        InkWell(
          onTap: () {
            // Handle shuffle action
            setState(() {
              _isShuffle = !_isShuffle;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: _isShuffle
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(0.7),
                  )
                : null,
            child: Image.asset(
              AppIcon.shuffle,
              scale: 20,
              color: !_isShuffle ? Colors.white : Colors.black.withOpacity(0.4),
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
          onTap: () => setState(() {
            _isInfinity = !_isInfinity;
          }),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: _isInfinity
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(0.7),
                  )
                : null,
            child: Image.asset(
              AppIcon.infinity,
              scale: 20,
              color:
                  !_isInfinity ? Colors.white : Colors.black.withOpacity(0.4),
            ),
          ),
        )
      ],
    );
  }
}
