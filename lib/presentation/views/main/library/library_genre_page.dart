import 'package:flutter/material.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/views/main/library/components/library_genre_item.dart';
import 'package:sound_sphere/presentation/views/main/library/components/library_header.dart';
import 'package:sound_sphere/presentation/views/main/library/components/search_bar_delegate.dart';

class LibraryGenrePage extends StatefulWidget {
  const LibraryGenrePage({super.key});

  @override
  State<LibraryGenrePage> createState() => _LibraryGenrePageState();
}

class _LibraryGenrePageState extends State<LibraryGenrePage> {
  final ScrollController _scrollController = ScrollController();
  bool isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset > 50 && !isScrolled) {
      setState(() {
        isScrolled = true;
      });
    } else if (_scrollController.offset <= 50 && isScrolled) {
      setState(() {
        isScrolled = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              LibraryPlaylistHeader(isScrolled: isScrolled, title: "Artists"),
              SliverPersistentHeader(
                pinned: true,
                delegate: SearchBarDelegate(),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: FakeData.genres.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: LibraryGenreItem(
                          genre: FakeData.genres.elementAt(index)),
                    );
                  },
                ),
                Container(
                  color: Colors.white,
                  height: 150,
                ),
              ],
            ),
          )),
    );
  }
}
