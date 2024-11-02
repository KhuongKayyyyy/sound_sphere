import 'package:flutter/material.dart';

class HistoryPlaylist extends StatelessWidget {
  final Color primaryColor = const Color(0xff7d4cff);
  final Color secondaryColor = const Color(0xff9487f5);
  final VoidCallback? onPressed;
  const HistoryPlaylist({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          height: 180,
          width: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: primaryColor, // Use the custom primaryColor
          ),
          child: Center(
            child: Stack(
              children: [
                Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(100)),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.replay_rounded,
                            color: Colors.white,
                          ),
                          Text(
                            "History",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          )),
    );
  }
}
