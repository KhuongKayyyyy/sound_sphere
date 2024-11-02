import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SocialButton extends StatelessWidget {
  String image;
  VoidCallback? onTap;
  SocialButton({super.key, required this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Image.asset(
          image,
          height: 30,
          width: 30,
        ),
      ),
    );
  }
}
