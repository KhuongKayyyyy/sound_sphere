import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';

class AppSearchBar extends StatefulWidget {
  final VoidCallback? onTap;
  const AppSearchBar({super.key, required this.onTap});

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search, // Search icon at the beginning
              color: Colors.grey,
            ),
            const SizedBox(width: 8), // Space between icon and text
            Expanded(
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  hintText: "Artists, songs, or lyrics and more", // Placeholder
                  hintStyle: TextStyle(
                    color: AppColor.inkGrey, // Text color
                  ),
                  border: InputBorder.none, // Remove underline border
                ),
                style: const TextStyle(
                  color: Colors.black, // Text color
                ),
              ),
            ),
            InkWell(
                onTap: () {},
                child: Icon(
                  CupertinoIcons.mic,
                  color: AppColor.inkGrey,
                ))
          ],
        ),
      ),
    );
  }
}
