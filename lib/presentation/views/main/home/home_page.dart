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
import 'package:sound_sphere/data/models/album.dart';
import 'package:sound_sphere/data/res/library_repository.dart';
import 'package:sound_sphere/presentation/blocs/album/album_bloc.dart';
import 'package:sound_sphere/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:sound_sphere/presentation/blocs/track/track_bloc.dart';
import 'package:sound_sphere/presentation/views/main/home/components/added_artist_button.dart';
import 'package:sound_sphere/presentation/views/main/home/components/best_album_section.dart';
import 'package:sound_sphere/presentation/views/main/home/components/history_playlist_button.dart';
import 'package:sound_sphere/presentation/views/main/home/components/mixed_playlist.dart';
import 'package:sound_sphere/presentation/views/main/home/components/playlist_section.dart';
import 'package:sound_sphere/presentation/views/main/home/components/media_section.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/presentation/widgets/media/media_item.dart';
import 'package:sound_sphere/presentation/widgets/search_bar/custom_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AlbumBloc albumBloc;
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
    final random = (DateTime.now().millisecondsSinceEpoch % 20) + 1;
    recommendTrackBloc.add(FetchTracksEvent(random, 10, TrackApi.previewTrack));
    hitTrackBloc = TrackBloc();
    // hitTrackBloc
    //     .add(FetchTracksEvent((random % 20) + 1, 10, TrackApi.previewTrack));

    hitTrackBloc.add(FetchTracksEvent(1, 10, TrackApi.previewTrack));

    albumBloc = AlbumBloc();
    albumBloc.add(FetchAlbumsPreviewEvent(1, 5));

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
        // SliverToBoxAdapter(
        //   child: TextButton(
        //     onPressed: () async {
        //       LibraryRepository()
        //           .removeTrackFromLibrary("6767be0c8b695e26ed4c6990");
        //     },
        //     child: const Text("Test"),
        //   ),
        // ),
        _buildAppUltilitySection(),
        _buildReccommendedMusicSection(),
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
              enabled: _showSkeleton,
              child:
                  const PlaylistSection(playlistSectionTitle: "Top Playlists"),
            ),
            _buildMediaSection(hitTrackBloc, "Top songs"),
            const SizedBox(height: 10),
            _buildNewsAlbumSection(),
            const SizedBox(height: 10),
            const PlaylistSection(playlistSectionTitle: "Made for you"),
            const SizedBox(height: 10),
            _buildMediaSection(recommendTrackBloc, "Songs you may love"),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: BestAlbumSection(
                onPressed: () => context.pushNamed(
                  Routes.albumDetail,
                  extra: "6767be228b695e26ed4c6c0f",
                ),
              ),
            ),
            const SizedBox(height: 150),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsAlbumSection() {
    return BlocBuilder<AlbumBloc, AlbumState>(
      bloc: albumBloc,
      builder: (context, state) {
        if (state is AlbumPreviewLoaded) {
          return _buildNewAlbumList(state.albums);
        } else if (state is AlbumPreviewError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is AlbumPreviewLoading) {
          return Skeletonizer(
            enabled: _showSkeleton,
            child: const PlaylistSection(playlistSectionTitle: "New albums"),
          );
        }
        return const SizedBox(child: Text("No event added"));
      },
    );
  }

  Widget _buildNewAlbumList(List<Album> albums) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "New albums",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                context.pushNamed(Routes.extendGridView, extra: {
                  'albums': albums,
                  'title': "New albums",
                });
              },
              icon: const Icon(Icons.arrow_forward_ios_rounded),
              padding: EdgeInsets.zero,
            )
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: ListView.builder(
            itemCount: albums.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: index == albums.length - 1 ? 10 : 0,
                  ),
                  child: MediaItem(album: albums[index]));
            },
          ),
        ),
      ],
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
              songList: FakeData.gnxTracks.take(5).toList(),
              isExpandable: true,
              onPressed: () => context.pushNamed(
                Routes.extendGridView,
                extra: {
                  'title': title,
                  'songs': FakeData.gnxTracks,
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
