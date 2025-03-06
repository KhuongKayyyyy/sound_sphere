import 'package:flutter/material.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/views/main/library/components/library_header.dart';
import 'package:sound_sphere/presentation/views/main/library/components/playlist_add_new.dart';
import 'package:sound_sphere/presentation/views/main/library/components/search_bar_delegate.dart';
import 'package:sound_sphere/presentation/widgets/playlist/horizontal_playlist.dart';

class LibraryPlaylistPage extends StatefulWidget {
  const LibraryPlaylistPage({super.key});

  @override
  State<LibraryPlaylistPage> createState() => _LibraryPlaylistPageState();
}

class _LibraryPlaylistPageState extends State<LibraryPlaylistPage> {
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
              LibraryPlaylistHeader(isScrolled: isScrolled, title: "Playlists"),
              SliverPersistentHeader(
                pinned: true,
                delegate: SearchBarDelegate(),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: [
                PlaylistAddNew(),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return HorizontalPlaylist(
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
              ],
            ),
          )),
    );
  }
}
