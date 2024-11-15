import 'package:flutter/material.dart';
import 'package:sound_sphere/core/controller/player_controller.dart';

class SongDuration extends StatefulWidget {
  PlayerController playerController = PlayerController();
  bool isSliding;
  SongDuration({super.key, required this.isSliding});

  @override
  State<SongDuration> createState() => _SongDurationState();
}

class _SongDurationState extends State<SongDuration> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: double.infinity,
            height: widget.isSliding ? 10 : 5, // Scale up height when sliding
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.white,
                  thumbColor: Colors.white,
                  thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: widget.isSliding ? 10.0 : 6.0),
                  overlayShape: RoundSliderOverlayShape(
                      overlayRadius: widget.isSliding ? 20.0 : 0),
                ),
                child: AnimatedBuilder(
                  animation: widget.playerController,
                  builder: (context, child) => Slider(
                    value: widget.playerController
                        .getCurrentPosition()
                        .inSeconds
                        .toDouble(),
                    max: widget.playerController
                        .getTotalDuration()
                        .inSeconds
                        .toDouble(),
                    onChanged: (value) async {
                      widget.playerController
                          .seekTo(Duration(seconds: value.toInt()));
                    },
                    onChangeStart: (value) {
                      setState(() {
                        widget.isSliding =
                            true; // Start scaling and color change
                      });
                    },
                    onChangeEnd: (value) {
                      setState(() {
                        widget.isSliding =
                            false; // End scaling and color change
                      });
                    },
                  ),
                ),
              ),
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            children: [
              AnimatedBuilder(
                  animation: widget.playerController,
                  builder: (context, child) {
                    return Text(
                      widget.playerController.getCurrentPositionString(),
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.bold),
                    );
                  }),
              const Spacer(),
              AnimatedBuilder(
                  animation: widget.playerController,
                  builder: (context, child) {
                    return Text(
                      widget.playerController.getRemainingDurationString(),
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.bold),
                    );
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
