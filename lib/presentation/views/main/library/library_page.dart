import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/views/main/library/components/library_album_item.dart';
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

  bool _showSkeleton = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _showSkeleton = false;
      });
    });
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
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              childAspectRatio: 0.85,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Skeletonizer(
                    enabled: _showSkeleton,
                    child: LibraryAlbumItem(album: FakeData.albums[index]));
              },
              childCount: FakeData.albums.length,
            ),
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
}
