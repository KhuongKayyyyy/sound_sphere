import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/views/authentication/authentication_page.dart';
import 'package:sound_sphere/presentation/views/main/home/components/added_artist_button.dart';
import 'package:sound_sphere/presentation/views/main/home/components/best_album_section.dart';
import 'package:sound_sphere/presentation/views/main/home/components/history_playlist_button.dart';
import 'package:sound_sphere/presentation/views/main/home/components/mixed_playlist.dart';
import 'package:sound_sphere/presentation/views/main/home/components/playlist_section.dart';
import 'package:sound_sphere/presentation/views/main/home/components/song_section.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController? _scrollController; // Nullable scroll controller
  bool showAvatar = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController!
        .addListener(_onScroll); // Add listener to scroll controller
  }

  @override
  void dispose() {
    _scrollController!.removeListener(_onScroll);
    _scrollController!.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Check the scroll offset and hide avatar when collapsed
    if (_scrollController!.offset >= 50 && showAvatar) {
      setState(() {
        showAvatar = false;
      });
    } else if (_scrollController!.offset < 50 && !showAvatar) {
      setState(() {
        showAvatar = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController, // Attach ScrollController
        slivers: [
          // app bar
          _buildHomePageAppBar(),
          // app utility section
          _buildAppUltilitySection(),
          // recommended music section
          _buildReccommendedMusicSection(),
        ],
      ),
    );
  }

  Widget _buildHomePageAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 80,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var appBarHeight = constraints.biggest.height;
          var isExpanded = appBarHeight > kToolbarHeight;

          return FlexibleSpaceBar(
            titlePadding: const EdgeInsets.only(left: 16, bottom: 8),
            title: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      textAlign:
                          isExpanded ? TextAlign.start : TextAlign.center,
                      'Listen now',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isExpanded ? 24.0 : 16.0,
                      ),
                    ),
                  ),
                  // if (isExpanded &&
                  //
                  //   showAvatar) // Only show avatar when expanded
                  IconButton(
                      onPressed: () {
                        _showLoginModal();
                      },
                      icon: Icon(
                        CupertinoIcons.person,
                        color: AppColor.primaryColor,
                      ))
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(100),
                  //   child: Image.network(
                  //     FakeData.user.avatarURL,
                  //     fit: BoxFit.cover,
                  //     width: 40,
                  //     height: 40,
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppUltilitySection() {
    return SliverToBoxAdapter(
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  AddedArtist(myArtistList: FakeData.artists.take(3).toList()),
                  const Spacer(),
                  HistoryPlaylist(
                    onPressed: () => context.pushNamed(Routes.historyPlaylist),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const MixedPlaylistSmall(),
            ],
          )),
    );
  }

  Widget _buildReccommendedMusicSection() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const PlaylistSection(playlistSectionTitle: "Top Playlists"),
          SongSection(
            songSectionTitle: "Today hits",
            songList: FakeData.songs.take(10).toList(),
            isExpandable: true,
          ),
          const SizedBox(height: 10),
          const PlaylistSection(playlistSectionTitle: "Made for you"),
          const SizedBox(height: 10),
          SongSection(
            songSectionTitle: "Son Tung MTP's fan like",
            songList: FakeData.songs.take(10).toList(),
            isExpandable: false,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: BestAlbumSection(
              onPressed: () => context.pushNamed(Routes.albumDetail,
                  extra: "albumId"), // Navigate to album detail page
            ),
          ),
          const SizedBox(height: 150),
        ],
      ),
    );
  }

  void _showLoginModal() {
    // Show login modal
    showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        isScrollControlled: true, // Make the modal fullscreen
        builder: (context) => const LoginPage());
  }
}