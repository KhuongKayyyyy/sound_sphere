import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';

class PlayerFunction extends StatefulWidget {
  bool isShowPlaylist;
  PlayerFunction({super.key, required this.isShowPlaylist});

  @override
  State<PlayerFunction> createState() => _PlayerFunctionState();
}

class _PlayerFunctionState extends State<PlayerFunction> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          child: Image.asset(
            AppIcon.lyrics,
            scale: 20,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
        InkWell(
          child: Image.asset(
            AppIcon.airplay,
            scale: 20,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.timer_sharp,
              color: Colors.white.withOpacity(0.7),
              size: 35,
            )),
        IconButton(
            onPressed: () {
              setState(() {
                widget.isShowPlaylist = !widget.isShowPlaylist;
              });
            },
            icon: Icon(
              Icons.list_rounded,
              color: Colors.white.withOpacity(0.7),
              size: 35,
            ))
      ],
    );
  }
}
