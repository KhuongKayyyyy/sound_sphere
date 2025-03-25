import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/data/models/track_in_library.dart';
import 'package:sound_sphere/presentation/blocs/library/library_bloc.dart';
import 'package:sound_sphere/presentation/views/main/library/components/library_item.dart';
import 'package:sound_sphere/presentation/views/main/library/components/library_type_section.dart';
import 'package:sound_sphere/presentation/widgets/search_bar/custom_app_bar.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  bool showAppBar = false;
  late final ScrollController _scrollController;
  double previousScrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    if (context.read<LibraryBloc>().state is! TrackLibraryLoaded) {
      context.read<LibraryBloc>().add(GetTrackLibraryRequest());
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    double currentOffset = _scrollController.offset;
    bool isScrollingDown = currentOffset > previousScrollOffset;

    if (isScrollingDown && currentOffset > 120 && !showAppBar) {
      setState(() {
        showAppBar = true;
      });
    } else if (!isScrollingDown && currentOffset <= 120 && showAppBar) {
      setState(() {
        showAppBar = false;
      });
    }

    previousScrollOffset = currentOffset;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          CustomAppBar(title: "Library"),
          LibraryTypeSection(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Text(
                "Recently Added",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          BlocBuilder<LibraryBloc, LibraryState>(
            builder: (context, state) {
              if (state is TrackLibraryLoaded) {
                return _buildLibGrid(state.tracks, state.favoriteTracks);
              } else if (state is LibraryLoading) {
                return SliverToBoxAdapter(
                  child: Skeletonizer(
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: 6, // Show 6 skeleton items
                      itemBuilder: (context, index) {
                        return LibraryItem(
                          track: FakeData.gnxTracks.first,
                        );
                      },
                    ),
                  ),
                );
              }
              return SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  height: 150,
                ),
              );
            },
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              height: 150,
            ),
          ),
        ],
      ),
    );
  }

  SliverGrid _buildLibGrid(
      List<Track> tracks, List<TrackInLibrary> favoriteTracks) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        childAspectRatio: 0.85,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          bool isFavorite =
              favoriteTracks.any((favTrack) => favTrack.id == tracks[index].id);
          return LibraryItem(
            track: tracks[index],
            isFavorite: isFavorite,
            onTap: () {
              context.pushNamed(
                Routes.detailLibrary,
                extra: tracks[index],
              );
            },
          );
        },
        childCount: tracks.length,
      ),
    );
  }
}
