import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YearReplayButton extends StatelessWidget {
  VoidCallback? onPressed;
  final Color backgroundColor = Color.fromRGBO(247, 243, 235, 1);
  YearReplayButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 150,
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.music_note_2,
                  size: 15,
                ),
                const Text(
                  "SoundSphere",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                "'24",
                style: TextStyle(
                  fontSize: 58,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              "R e p l a y",
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
