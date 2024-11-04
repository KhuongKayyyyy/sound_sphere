import 'package:flutter/material.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/views/main/library/components/library_album_item.dart';
import 'package:sound_sphere/presentation/views/main/library/components/library_app_bar.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  int _currentIndex = 0;
  bool showAppBar = false;
  late final ScrollController _scrollController;
  double previousScrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
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
          LibraryAppBar(
            currentIndex: _currentIndex,
            onTabSelected: (int value) {
              setState(() {
                _currentIndex = value;
              });
            },
            showAppBarTitle: showAppBar,
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 20)),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              childAspectRatio: 0.9,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return LibraryAlbumItem(album: FakeData.albums[index]);
              },
              childCount: FakeData.albums.length,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.black,
              height: 2000,
            ),
          ),
        ],
      ),
    );
  }
}
