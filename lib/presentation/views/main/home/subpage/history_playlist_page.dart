import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_image.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/presentation/widgets/button/play_blur_button.dart';
import 'package:sound_sphere/presentation/widgets/button/shuffe_play_button.dart';
import 'package:sound_sphere/presentation/widgets/search_bar/custom_search_bar.dart';
import 'package:sound_sphere/presentation/widgets/track/track_item.dart';

class HistoryPlaylistPage extends StatefulWidget {
  const HistoryPlaylistPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HistoryPlaylistPageState createState() => _HistoryPlaylistPageState();
}

class _HistoryPlaylistPageState extends State<HistoryPlaylistPage> {
  final List<Track> songList = FakeData.obitoSongs.take(10).toList();
  ScrollController? _scrollController;
  bool showSearchBar = true;
  bool showAppBarTitle = false; // Track whether to show app bar title

  Color appBarIconColor = Colors.white; // Initial color for icons

  @override
  void initState() {
    super.initState();
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
    if (_scrollController!.offset > 250 && !showAppBarTitle) {
      setState(() {
        showAppBarTitle = true;
      });
    } else if (_scrollController!.offset <= 250 && showAppBarTitle) {
      setState(() {
        showAppBarTitle = false;
      });
    }

    // if (_scrollController!.offset > 400 && showSearchBar) {
    //   setState(() {
    //     showSearchBar = false;
    //   });
    // } else if (_scrollController!.offset <= 400 && !showSearchBar) {
    //   setState(() {
    //     showSearchBar = true;
    //   });
    // }

    // Change icon color based on scroll position
    if (_scrollController!.offset > 250) {
      setState(() {
        appBarIconColor = AppColor.primaryColor; // Change to primary color
      });
    } else {
      setState(() {
        appBarIconColor = Colors.white; // Change back to white
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _buildHistoryPlayPageAppBar(context),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 10),
                // if (showSearchBar)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomSearchBar(
                    textHint: "What should we listen to?",
                    isWhite: false,
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
          SliverPadding(
            padding:
                const EdgeInsets.only(bottom: 150), // Bottom padding for list
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return TrackItem(
                    track: songList[index],
                  );
                },
                childCount: songList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildHistoryPlayPageAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 300,
      leading: Container(
        margin: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withOpacity(0.1),
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: appBarIconColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      actions: [
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Colors.black.withOpacity(0.1)),
          height: kToolbarHeight,
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            icon: Icon(Icons.notifications_on, color: appBarIconColor),
            alignment: Alignment.center,
          ),
        ),
        const SizedBox(width: 10),
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Colors.black.withOpacity(0.1)),
          height: kToolbarHeight,
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            icon: Icon(Icons.more_horiz_rounded, color: appBarIconColor),
            alignment: Alignment.center,
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImage.historyPlaylistBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "Listening History",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              const SizedBox(height: 10),
              Text(
                "Sound Sphere for Khương",
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                "Updated today",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(child: PlayBlurButton()),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(child: ShufflePlayButton())
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Song that you can't get enough lately, all in one place",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
        title: showAppBarTitle
            ? const Text(
                "Listening History",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              )
            : null,
        centerTitle: true,
      ),
    );
  }
}
