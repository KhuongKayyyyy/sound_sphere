import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/playlist.dart';
import 'package:sound_sphere/presentation/blocs/playlist/playlist_bloc.dart';
import 'package:sound_sphere/presentation/views/main/library/components/library_header.dart';
import 'package:sound_sphere/presentation/views/main/library/components/playlist_add_new.dart';
import 'package:sound_sphere/presentation/views/main/library/components/search_bar_delegate.dart';
import 'package:sound_sphere/presentation/widgets/playlist/horizontal_playlist_item.dart';

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

    if (context.read<PlaylistBloc>().state is! PlaylistGetSuccess) {
      context.read<PlaylistBloc>().add(PlaylistGetListRequested());
    }
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
                BlocBuilder<PlaylistBloc, PlaylistState>(
                  builder: (context, playlistState) {
                    if (playlistState is PlaylistLoading) {
                      return Skeletonizer(
                          enabled: true,
                          child: _buildPlaylistList(FakeData.playlists));
                    } else if (playlistState is PlaylistGetFailure) {
                      return Center(
                        child: Text(playlistState.message),
                      );
                    } else if (playlistState is PlaylistGetSuccess) {
                      return _buildPlaylistList(playlistState.playlists);
                    }
                    return Container();
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

  ListView _buildPlaylistList(List<Playlist> playlists) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return HorizontalPlaylistItem(
          playlist: playlists[index],
          onPressed: () {
            context.pushNamed(Routes.playlistDetailPage,
                extra: playlists[index]);
          },
        );
      },
      itemCount: playlists.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
