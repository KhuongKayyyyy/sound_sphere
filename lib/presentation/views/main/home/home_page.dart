import 'dart:async'; // Import the Timer class
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sound_sphere/core/constant/api_config.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/res/playlist_repository.dart';
import 'package:sound_sphere/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:sound_sphere/presentation/blocs/track/track_bloc.dart';
import 'package:sound_sphere/presentation/views/main/home/components/added_artist_button.dart';
import 'package:sound_sphere/presentation/views/main/home/components/best_album_section.dart';
import 'package:sound_sphere/presentation/views/main/home/components/history_playlist_button.dart';
import 'package:sound_sphere/presentation/views/main/home/components/mixed_playlist.dart';
import 'package:sound_sphere/presentation/views/main/home/components/playlist_section.dart';
import 'package:sound_sphere/presentation/views/main/home/components/media_section.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/presentation/widgets/search_bar/custom_app_bar.dart';

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
  bool _showSkeleton = true;

  @override
  void initState() {
    super.initState();
    FlutterSecureStorage()
        .read(key: ApiConfig.refreshToken)
        .then((refreshToken) {
      if (refreshToken != null) {
        // print("Refresh Token: $refreshToken");
      } else {
        // print("No refresh token found");
      }
    });

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
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, authState) {
          if (authState is AuthGetUserSuccess) {
            return _buildHomeBody();
          } else if (authState is AuthGetUserFailure) {
            return CustomScrollView(
              slivers: [
                CustomAppBar(
                  title: "Listen now",
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        AppColor.primaryColor,
                        AppColor.secondaryColor
                      ]),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Explore 100 million songs. All ad-free.",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.music_note_2,
                              color: Colors.white,
                              size: 40,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.grey,
                                  offset: Offset(2.0, 2.0),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Sound Sphere",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                height: 1.5,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10.0,
                                    color: Colors.grey,
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const Spacer(),
                        Text("Try it now",
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Text("Plan auto-renews for 65.000 VND/month.",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (authState is AuthLoading) {
            Skeletonizer(
              enabled: _showSkeleton,
              child: _buildHomeBody(),
            );
          }
          return Skeletonizer(
            enabled: _showSkeleton,
            child: _buildHomeBody(),
          );
        },
      ),
    );
  }

  CustomScrollView _buildHomeBody() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        CustomAppBar(title: "Listen now"),
        SliverToBoxAdapter(
          child: TextButton(
            onPressed: () async {
              // String? token =
              //     await FlutterSecureStorage().read(key: ApiConfig.token);
              // print(token);
              // String? refreshToken = await FlutterSecureStorage()
              //     .read(key: ApiConfig.refreshToken);
              PlaylistRepository().addAlbumToPlayList(
                  playlistId: "67d90e42ab731fac82a68f22",
                  albumId: "6767be0e8b695e26ed4c69d0");
            },
            child: const Text("Test"),
          ),
        ),
        _buildReccommendedMusicSection(),
        _buildAppUltilitySection(),
      ],
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
}
