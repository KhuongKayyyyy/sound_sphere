import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

// ignore: must_be_immutable
class WaveBackground extends StatelessWidget {
  List<Color> colorList;
  WaveBackground({super.key, required this.colorList});

  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      config: CustomConfig(
        gradients: [
          [
            colorList[0],
            colorList[1],
          ],
          [
            colorList[2],
            colorList[3],
          ],
          [
            colorList[4],
            colorList[5],
          ],
          [
            colorList[6],
            colorList[7],
          ],
        ],
        durations: [19440, 10800, 6000, 13440],
        heightPercentages: [0.20, 0.35, 0.25, 0.30],
        blur: const MaskFilter.blur(BlurStyle.solid, 2),
        gradientBegin: Alignment.bottomLeft,
        gradientEnd: Alignment.topRight,
      ),
      waveAmplitude: 0,
      size: const Size(double.infinity, 80),
    );
  }
}
