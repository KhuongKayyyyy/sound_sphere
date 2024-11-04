import 'package:flutter/material.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/views/main/library/components/library_album_item.dart';
import 'package:sound_sphere/presentation/views/main/library/components/library_app_bar.dart';
import 'package:sound_sphere/presentation/views/main/library/components/library_artist_item.dart';
import 'package:sound_sphere/presentation/views/main/library/components/library_genre_list.dart';

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
          Builder(
            builder: (context) {
              switch (_currentIndex) {
                case 0:
                  return SliverGrid(
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
                  );
                case 1:
                  return SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.85,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: LibraryArtistItem(
                              artist: FakeData.artists[index]),
                        );
                      },
                      childCount: FakeData.artists.length,
                    ),
                  );
                default:
                  return SliverToBoxAdapter(
                    child: Column(
                      children: [
                        LibraryGenreList(
                            genres: FakeData.genres.take(3).toList()),
                        LibraryGenreList(
                            genres: FakeData.genres.skip(3).take(5).toList()),
                        LibraryGenreList(
                            genres: FakeData.genres.skip(8).toList())
                      ],
                    ),
                  );
              }
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
}
