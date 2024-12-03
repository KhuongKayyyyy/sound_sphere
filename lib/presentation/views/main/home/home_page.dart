import 'dart:async'; // Import the Timer class
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sound_sphere/core/constant/api_config.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/res/track_repository.dart';
import 'package:sound_sphere/presentation/blocs/track/track_bloc.dart';
import 'package:sound_sphere/presentation/views/authentication/authentication_page.dart';
import 'package:sound_sphere/presentation/views/main/home/components/added_artist_button.dart';
import 'package:sound_sphere/presentation/views/main/home/components/best_album_section.dart';
import 'package:sound_sphere/presentation/views/main/home/components/history_playlist_button.dart';
import 'package:sound_sphere/presentation/views/main/home/components/mixed_playlist.dart';
import 'package:sound_sphere/presentation/views/main/home/components/playlist_section.dart';
import 'package:sound_sphere/presentation/views/main/home/components/media_section.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TrackBloc recommendTrackBloc;
  late TrackBloc hitTrackBloc;
  ScrollController? _scrollController;
  bool showAvatar = true;
  bool _showSkeleton = true; // State to control the skeleton visibility

  @override
  void initState() {
    super.initState();

    Timer(const Duration(microseconds: 1500), () {
      setState(() {
        _showSkeleton = false;
      });
    });

    recommendTrackBloc = TrackBloc();
    recommendTrackBloc
        .add(const FetchTracksEvent(1, 10, TrackApi.previewTrack));
    hitTrackBloc = TrackBloc();
    hitTrackBloc.add(const FetchTracksEvent(2, 10, TrackApi.previewTrack));

    _scrollController = ScrollController();
    _scrollController!.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController!.removeListener(_onScroll);
    _scrollController!.dispose();
    super.dispose();
  }

  void _onScroll() {
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
        controller: _scrollController,
        slivers: [
          _buildHomePageAppBar(),
          _buildAppUltilitySection(),
          SliverToBoxAdapter(
            child: TextButton(
              onPressed: () {
                TrackRepository.getTopTrackByPlay();
              },
              child: const Text("Test"),
            ),
          ),
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
                        color: Colors.black,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _showLoginModal,
                    icon: Icon(
                      CupertinoIcons.person,
                      color: AppColor.primaryColor,
                    ),
                  ),
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
      child: Skeletonizer(
        enabled: _showSkeleton,
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
          ),
        ),
      ),
    );
  }

  Widget _buildReccommendedMusicSection() {
    return SliverToBoxAdapter(
      child: Skeletonizer(
        enabled: _showSkeleton,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Skeletonizer(
              enabled: _showSkeleton, // Control skeleton visibility
              child:
                  const PlaylistSection(playlistSectionTitle: "Top Playlists"),
            ),
            _buildMediaSection(hitTrackBloc, "Top songs"),
            const SizedBox(height: 10),
            const PlaylistSection(playlistSectionTitle: "Made for you"),
            const SizedBox(height: 10),
            _buildMediaSection(recommendTrackBloc, "Son Tung MTP's hits"),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: BestAlbumSection(
                onPressed: () => context.pushNamed(
                  Routes.albumDetail,
                  extra: "6747e52700a1fcb7eb635fbb",
                ),
              ),
            ),
            const SizedBox(height: 150),
          ],
        ),
      ),
    );
  }

  BlocBuilder<TrackBloc, TrackState> _buildMediaSection(
      TrackBloc trackBloc, String title) {
    return BlocBuilder<TrackBloc, TrackState>(
      bloc: trackBloc,
      builder: (context, trackState) {
        if (trackState is TracksLoading) {
          return Skeletonizer(
            enabled: _showSkeleton, // Control skeleton visibility
            child: MediaSection(
              mediaSectionTitle: title,
              songList: FakeData.obitoSongs.take(5).toList(),
              isExpandable: true,
              onPressed: () => context.pushNamed(
                Routes.extendGridView,
                extra: {
                  'songs': FakeData.obitoSongs,
                  'title': title,
                },
              ),
            ),
          );
        } else if (trackState is TracksLoaded) {
          return MediaSection(
            mediaSectionTitle: title,
            songList: trackState.tracks,
            isExpandable: true,
            onPressed: () => context.pushNamed(
              Routes.extendGridView,
              extra: {
                'songs': trackState.tracks,
                'title': title,
              },
            ),
          );
        } else if (trackState is TracksError) {
          return Center(
            child: Text(trackState.message),
          );
        }
        return const SizedBox(child: Text("No event added"));
      },
    );
  }

  void _showLoginModal() {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (context) => const LoginPage(),
    );
  }
}
