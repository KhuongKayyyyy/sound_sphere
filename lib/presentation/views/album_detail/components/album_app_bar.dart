import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/data/models/album.dart';

class AlbumDetailAppBar extends StatelessWidget {
  final Album tempAlbum;
  final bool showAppBarTitle;
  final Color appBarIconColor;
  final void Function(BuildContext) showCupertinoBottomSheet;

  const AlbumDetailAppBar({
    super.key,
    required this.tempAlbum,
    required this.showAppBarTitle,
    required this.appBarIconColor,
    required this.showCupertinoBottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 300,
      leadingWidth: 120,
      leading: Row(
        children: [
          _buildCircleIcon(
            context: context,
            icon: Icons.arrow_back,
            onPressed: () => Navigator.pop(context),
          ),
          _buildCircleIcon(
            context: context,
            icon: Icons.info,
            onPressed: () => showCupertinoBottomSheet(context),
          ),
        ],
      ),
      actions: [
        _buildCircleIcon(
          context: context,
          icon: Icons.add,
          onPressed: () {},
        ),
        const SizedBox(width: 10),
        _buildCircleIcon(
          context: context,
          icon: Icons.more_horiz_rounded,
          onPressed: () {},
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: showAppBarTitle
            ? Text(
                tempAlbum.title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
              )
            : null,
        centerTitle: true,
        background: _buildBackground(context),
      ),
    );
  }

  Widget _buildCircleIcon({
    required BuildContext context,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withOpacity(0.1),
      ),
      child: IconButton(
        icon: Icon(icon),
        color: appBarIconColor,
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildBackground(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(tempAlbum.imgURL),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            tempAlbum.title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              context.pushNamed(Routes.artistDetail, extra: 'artistId');
            },
            child: Text(
              tempAlbum.artistName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 10),
          _buildAlbumInfo(context),
        ],
      ),
    );
  }

  Widget _buildAlbumInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${tempAlbum.genre.name} · ${tempAlbum.releaseDate}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _buildIcon(AppIcon.quality),
                  _buildIcon(AppIcon.audio),
                  _buildIcon(AppIcon.dolby),
                ],
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              _buildPlaybackButton(context, AppIcon.shuffle, null),
              _buildPlaybackButton(context, null, Icons.play_arrow),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(String assetPath) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: SizedBox(
        height: 20,
        width: 20,
        child: Image.asset(
          assetPath,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildPlaybackButton(
      BuildContext context, String? assetPath, IconData? icon) {
    return Container(
      height: 48,
      width: 48,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColor.primaryColor,
      ),
      child: IconButton(
        icon: icon != null
            ? Icon(icon, color: Colors.white)
            : Image.asset(assetPath!, color: Colors.white),
        onPressed:
            icon != null ? () => GoRouter.of(context).go('/player') : null,
      ),
    );
  }
}
