import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/views/main/library/components/library_item.dart';
import 'package:sound_sphere/presentation/views/main/library/components/library_header.dart';
import 'package:sound_sphere/presentation/views/main/library/components/search_bar_delegate.dart';
import 'package:sound_sphere/presentation/widgets/button/primary_button.dart';

class LibraryAlbumPage extends StatefulWidget {
  const LibraryAlbumPage({super.key});

  @override
  State<LibraryAlbumPage> createState() => _LibraryAlbumPageState();
}

class _LibraryAlbumPageState extends State<LibraryAlbumPage> {
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
              LibraryPlaylistHeader(isScrolled: isScrolled, title: "Albums"),
              SliverPersistentHeader(
                pinned: true,
                delegate: SearchBarDelegate(),
              ),
            ];
          },
          body: CustomScrollView(slivers: [
            _buildPlaySection(),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                childAspectRatio: 0.85,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return LibraryItem(album: FakeData.albums[index]);
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
          ])),
    );
  }

  Widget _buildPlaySection() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Row(
          children: [
            PrimaryButton(icon: AppIcon.play, text: "Play", onTap: () {}),
            PrimaryButton(icon: AppIcon.shuffle, text: "Shuffle", onTap: () {})
          ],
        ),
      ),
    );
  }
}
