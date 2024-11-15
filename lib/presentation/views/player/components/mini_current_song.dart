import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/controller/player_controller.dart';

class MiniCurrentSong extends StatefulWidget {
  final PlayerController playerController = PlayerController();
  bool isFavorite;
  MiniCurrentSong({super.key, required this.isFavorite});

  @override
  State<MiniCurrentSong> createState() => _MiniCurrentSongState();
}

class _MiniCurrentSongState extends State<MiniCurrentSong> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 80,
          width: 80,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: AnimatedBuilder(
                  animation: widget.playerController,
                  builder: (context, child) {
                    return Image.network(
                        widget.playerController.getCurrentSong().imgURL,
                        fit: BoxFit.cover);
                  })),
        ),
        const SizedBox(width: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 180,
              child: AnimatedBuilder(
                  animation: widget.playerController,
                  builder: (context, child) {
                    return Text(
                      widget.playerController.getCurrentSong().title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    );
                  }),
            ),
            SizedBox(
              width: 180,
              child: Text(
                widget.playerController.getCurrentSong().artistName,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  widget.isFavorite = !widget.isFavorite;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.3),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: widget.isFavorite
                      ? Icon(
                          Icons.favorite,
                          color: AppColor.primaryColor,
                          key: const ValueKey('favorite'),
                        )
                      : const Icon(
                          Icons.favorite_border_rounded,
                          color: Colors.white,
                          key: ValueKey('not_favorite'),
                        ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.3),
                ),
                child:
                    const Icon(Icons.more_horiz_rounded, color: Colors.white),
              ),
            ),
          ],
        )
      ],
    );
  }
}
