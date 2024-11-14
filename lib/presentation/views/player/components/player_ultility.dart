import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';

class PlayerUltility extends StatefulWidget {
  bool isShowLyric;
  bool isShowPlaylist;
  bool isInMenu;
  PlayerUltility(
      {super.key,
      required this.isShowLyric,
      required this.isShowPlaylist,
      required this.isInMenu});

  @override
  State<PlayerUltility> createState() => _PlayerUltilityState();
}

class _PlayerUltilityState extends State<PlayerUltility> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        !widget.isShowLyric
            ? InkWell(
                onTap: () {
                  setState(() {
                    if (widget.isInMenu == true) {
                      widget.isShowPlaylist = !widget.isShowPlaylist;
                      widget.isShowLyric = !widget.isShowLyric;
                    } else {
                      widget.isInMenu = !widget.isInMenu;
                      widget.isShowLyric = !widget.isShowLyric;
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                  ),
                  child: Image.asset(
                    AppIcon.lyrics,
                    scale: 20,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              )
            : InkWell(
                onTap: () {
                  setState(() {
                    widget.isInMenu = !widget.isInMenu;
                    widget.isShowLyric = !widget.isShowLyric;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(0.7),
                  ),
                  child: Image.asset(
                    AppIcon.lyrics,
                    scale: 20,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
        InkWell(
          onTap: () {}, // Airplay functionality
          child: Image.asset(
            AppIcon.airplay,
            scale: 20,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
        IconButton(
          onPressed: () {}, // Timer functionality
          icon: Icon(
            Icons.timer_sharp,
            color: Colors.white.withOpacity(0.7),
            size: 35,
          ),
        ),
        !widget.isShowPlaylist
            ? IconButton(
                onPressed: () {
                  setState(() {
                    if (widget.isInMenu == true) {
                      widget.isShowLyric = !widget.isShowLyric;
                      widget.isShowPlaylist = !widget.isShowPlaylist;
                    } else {
                      widget.isInMenu = !widget.isInMenu;
                      widget.isShowPlaylist = !widget.isShowPlaylist;
                    }
                  });
                },
                icon: Icon(
                  Icons.list_rounded,
                  color: Colors.white.withOpacity(0.7),
                  size: 35,
                ),
              )
            : Container(
                // padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withOpacity(0.7),
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      widget.isInMenu = !widget.isInMenu;
                      widget.isShowPlaylist = !widget.isShowPlaylist;
                    });
                  },
                  icon: Icon(
                    Icons.list_rounded,
                    color: Colors.black.withOpacity(0.7),
                    size: 35,
                  ),
                ),
              ),
      ],
    );
  }
}
