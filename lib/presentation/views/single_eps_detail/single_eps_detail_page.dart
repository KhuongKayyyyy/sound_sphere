import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/controller/player_controller.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/core/utils/helpers.dart';
import 'package:sound_sphere/data/models/album.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/data/res/track_repository.dart';
import 'package:sound_sphere/presentation/blocs/track/track_bloc.dart';
import 'package:sound_sphere/presentation/widgets/album/album_item.dart';
import 'package:sound_sphere/presentation/widgets/media/media_item.dart';
import 'package:sound_sphere/presentation/widgets/track/track_item.dart';

// ignore: must_be_immutable
class SingleEPsDetailPage extends StatefulWidget {
  String trackId;
  SingleEPsDetailPage({super.key, required this.trackId});

  @override
  State<SingleEPsDetailPage> createState() => _SingleEPsDetailPageState();
}

class _SingleEPsDetailPageState extends State<SingleEPsDetailPage> {
  bool showAppBarTitle = false;
  ScrollController _scrollController = ScrollController();
  List<Track> recommendTracks = [];
  String _duration = "Fetching duration...";

  bool showSkeleton = true;

  Track track = Track.defaultTrack();
  late TrackBloc trackBloc;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    trackBloc = TrackBloc();
    trackBloc.add(FetchTrackDetail(widget.trackId));
    // fetchDuration();

    Timer(const Duration(seconds: 1), () {
      setState(() {
        showSkeleton = false;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  // Future<void> fetchDuration() async {
  //   await widget.trackId.fetchDuration();
  //   setState(() {
  //     _duration = widget.trackId.duration;
  //   });
  // }

  void _onScroll() {
    if (_scrollController.offset > 250 && !showAppBarTitle) {
      setState(() {
        showAppBarTitle = true;
      });
    } else if (_scrollController.offset <= 250 && showAppBarTitle) {
      setState(() {
        showAppBarTitle = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TrackBloc, TrackState>(
        bloc: trackBloc,
        builder: (context, state) {
          if (state is TrackDetailLoaded) {
            track = state.track;
            recommendTracks = state.trackByArtist;
            return _buildSingleDetailPage();
          } else if (state is TrackDetailError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is TrackDetailLoading) {
            return Skeletonizer(
              enableSwitchAnimation: true,
              child: _buildSingleDetailPage(),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  CustomScrollView _buildSingleDetailPage() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        _buildSingleDetailAppBar(),
        _buildSingleDetailSection(),
        _buildPlaySection(),
        _buildSingleSongList(),
        _buildSingleBriefInfo(),
        _buildRecommendationSection(),
      ],
    );
  }

  SliverToBoxAdapter _buildRecommendationSection() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            _buildAritstMusic("More by ${track.artist.name}",
                songList: recommendTracks),
            _buildAritstMusic("Feature on", albumList: FakeData.albums),
            const SizedBox(
              height: 150,
            )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSingleSongList() {
    return SliverToBoxAdapter(
        child: TrackItem(
      track: track,
      isLiked: false,
      index: 1,
    ));
  }

  Widget _buildSingleDetailAppBar() {
    return SliverAppBar(
      toolbarHeight: 50,
      pinned: true,
      title: showAppBarTitle
          ? Text(
              track.title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
            )
          : null,
      centerTitle: true,
      actions: [
        _buildAppBarIcon(Icons.favorite_outline_rounded, () {}),
        const SizedBox(
          width: 10,
        ),
        _buildAppBarIcon(Icons.more_horiz_rounded, () {}),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Widget _buildAppBarIcon(IconData icon, Function() onTap) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(5),
            child: Icon(
              icon,
              size: 20,
            )),
      ),
    );
  }

  Widget _buildSingleDetailSection() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ]),
            height: 200,
            width: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                track.imgURL,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "${track.title}- Single",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            onTap: () {
              context.pushNamed(Routes.artistDetail, extra: track.artist);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                track.getArtistsAsString(),
                style: TextStyle(
                    fontSize: 20,
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Text(
            "${track.getGenresAsString()} · ${Helpers.getYearFromReleaseDate(track.releaseDate!)} · Lossless",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaySection() {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          _buildPlayButton(AppIcon.play, "Play", () {
            PlayerController().setPlayerAudio([track]);
            PlayerController().isPlayingAlbum = false;
          }),
          _buildPlayButton(AppIcon.shuffle, "Shuffle", () {
            TrackRepository.getTrackOfArtist(track.artist.name!);
          }),
        ],
      ),
    );
  }

  Widget _buildPlayButton(String icon, String text, Function() onTap) {
    return Expanded(
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                scale: 30,
                color: AppColor.primaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSingleBriefInfo() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Helpers.formatDate(track.releaseDate!),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[400]),
            ),
            Text(
              "1 song, 4 minutes",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[400]),
            ),
            Text(
              "© ${track.getArtistsAsString()} ${Helpers.getYearFromReleaseDate(track.releaseDate!)} ${track.album}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[400]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAritstMusic(String sectionName,
      {List<Track>? songList, List<Album>? albumList}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: InkWell(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  sectionName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w900),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey,
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        if (songList != null)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: songList.length,
              itemBuilder: (context, index) {
                if (songList[index].id == track.id) {
                  return const SizedBox();
                } else {
                  return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: MediaItem(track: songList[index]));
                }
              },
            ),
          ),
        if (albumList != null)
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: albumList.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: AlbumItem(album: albumList[index]));
              },
            ),
          ),
      ],
    );
  }
}
