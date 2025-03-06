import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/presentation/views/main/library/components/library_type_item.dart';

class LibraryTypeSection extends StatefulWidget {
  const LibraryTypeSection({super.key});

  @override
  State<LibraryTypeSection> createState() => _LibraryTypeSectionState();
}

class _LibraryTypeSectionState extends State<LibraryTypeSection> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          LibraryTypeItem(
            icon: CupertinoIcons.music_note_list,
            title: "Playlist",
            onTap: () {
              context.pushNamed(Routes.playlistLibrary);
            },
          ),
          LibraryTypeItem(
            icon: CupertinoIcons.music_mic,
            title: "Artists",
            onTap: () {
              context.pushNamed(Routes.artistLibrary);
            },
          ),
          LibraryTypeItem(
            icon: CupertinoIcons.music_albums,
            title: "Albums",
            onTap: () {
              context.pushNamed(Routes.albumLibrary);
            },
          ),
          LibraryTypeItem(
            icon: CupertinoIcons.music_note,
            title: "Songs",
            onTap: () {
              context.pushNamed(Routes.songLibrary);
            },
          ),
          LibraryTypeItem(
            icon: CupertinoIcons.double_music_note,
            title: "Made for you",
            onTap: () {
              context.pushNamed(Routes.made4uLibrary);
            },
          ),
          LibraryTypeItem(
            icon: CupertinoIcons.guitars,
            title: "Genres",
            onTap: () {
              context.pushNamed(Routes.genreLibrary);
            },
          ),
          LibraryTypeItem(
              icon: CupertinoIcons.music_house, title: "Music videos"),
          LibraryTypeItem(
              icon: CupertinoIcons.tv_music_note, title: "Complitations"),
          LibraryTypeItem(
            icon: CupertinoIcons.chevron_down_circle,
            title: "Downloaded",
            onTap: () {
              context.pushNamed(Routes.download);
            },
          ),
        ],
      ),
    );
  }
}
