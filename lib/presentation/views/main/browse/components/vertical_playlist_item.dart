import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/router/routes.dart';

class VerticalPlaylistItem extends StatelessWidget {
  final String img;
  final String title;
  final String subtitle;
  final bool isBig;
  final Function()? onTap;

  const VerticalPlaylistItem({
    required this.img,
    required this.isBig,
    required this.title,
    required this.subtitle,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap != null
          ? onTap!()
          : GoRouter.of(context).goNamed(Routes.playlistDetail),
      child: Column(
        children: [
          Container(
            height: isBig ? 150 : 180,
            width: isBig ? 330 : 180,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                img,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
