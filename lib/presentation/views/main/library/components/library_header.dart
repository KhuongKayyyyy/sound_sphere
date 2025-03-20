import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/app_color.dart';

class LibraryPlaylistHeader extends StatefulWidget {
  final String title;
  final bool isScrolled;
  final Function? onTap;

  const LibraryPlaylistHeader(
      {super.key, required this.isScrolled, required this.title, this.onTap});

  @override
  State<LibraryPlaylistHeader> createState() => _LibraryPlaylistHeaderState();
}

class _LibraryPlaylistHeaderState extends State<LibraryPlaylistHeader> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leadingWidth: 100,
      leading: InkWell(
        onTap: () {
          context.pop();
        },
        child: Container(
          padding: EdgeInsets.only(left: 16),
          child: Row(
            children: [
              Icon(
                Icons.arrow_back_ios,
                color: AppColor.primaryColor,
              ),
              Text(
                "Library",
                style: TextStyle(color: AppColor.primaryColor, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
      actions: [
        InkWell(
          onTap: () => widget.onTap != null ? widget.onTap!() : null,
          child: Container(
            decoration: BoxDecoration(
                color: AppColor.inkGreyLight,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 2),
                      blurRadius: 2)
                ]),
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(right: 16),
            child: Icon(
              CupertinoIcons.slider_horizontal_below_rectangle,
              color: AppColor.primaryColor,
            ),
          ),
        ),
      ],
      expandedHeight: 100,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: widget.isScrolled
            ? Text(widget.title,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold))
            : null, // Show title after scrolling 50px
        centerTitle: true,
        background: Container(
          padding: const EdgeInsets.only(left: 16, bottom: 16),
          alignment: Alignment.bottomLeft,
          child: Text(
            widget.title,
            style: TextStyle(
                fontSize: 26, color: Colors.black, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}
