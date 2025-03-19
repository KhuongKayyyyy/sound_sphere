import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/views/main/library/components/library_header.dart';
import 'package:sound_sphere/presentation/views/main/library/components/search_bar_delegate.dart';
import 'package:sound_sphere/presentation/widgets/button/primary_button.dart';
import 'package:sound_sphere/presentation/widgets/playlist/horizontal_playlist_item.dart';

class LibraryMade4uPage extends StatefulWidget {
  const LibraryMade4uPage({super.key});

  @override
  State<LibraryMade4uPage> createState() => _LibraryMade4uPageState();
}

class _LibraryMade4uPageState extends State<LibraryMade4uPage> {
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
              LibraryPlaylistHeader(
                  isScrolled: isScrolled, title: "Made for you"),
              SliverPersistentHeader(
                pinned: true,
                delegate: SearchBarDelegate(),
              ),
            ];
          },
          body: SingleChildScrollView(
              child: Column(children: [
            _buildPlaySection(),
            ListView.builder(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return HorizontalPlaylistItem(
                    onPressed: () {
                      context.pushNamed(Routes.playlistDetailPage,
                          extra: FakeData.playlists.elementAt(index));
                    },
                    playlist: FakeData.playlists.elementAt(index));
              },
              itemCount: FakeData.playlists.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
            Container(
              color: Colors.white,
              height: 150,
            ),
          ]))),
    );
  }

  Widget _buildPlaySection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Row(
        children: [
          PrimaryButton(icon: AppIcon.play, text: "Play", onTap: () {}),
          PrimaryButton(icon: AppIcon.shuffle, text: "Shuffle", onTap: () {})
        ],
      ),
    );
  }
}
