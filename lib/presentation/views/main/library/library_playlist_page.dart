import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/user_playlist.dart';
import 'package:sound_sphere/presentation/blocs/playlist/playlist_bloc.dart';
import 'package:sound_sphere/presentation/views/main/library/components/library_header.dart';
import 'package:sound_sphere/presentation/views/main/library/components/playlist_add_new.dart';
import 'package:sound_sphere/presentation/views/main/library/components/search_bar_delegate.dart';
import 'package:sound_sphere/presentation/widgets/playlist/horizontal_playlist_item.dart';

// ignore: must_be_immutable
class LibraryPlaylistPage extends StatefulWidget {
  String orderType = "Title";
  LibraryPlaylistPage({super.key});

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

  void updateOrderType(String orderType) async {
    setState(() {
      widget.orderType = orderType;
    });
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
                isScrolled: isScrolled,
                title: "Playlists",
                onTap: () {
                  _showPlaylistLibraryMenu(context);
                },
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: SearchBarDelegate(onTap: () {
                  showSearch(
                      context: context, delegate: PlayListSearchDelegate());
                }),
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

  Future<dynamic> _showPlaylistLibraryMenu(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text('Options'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                updateOrderType("Title");
              },
              child: Text('Title'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                updateOrderType("Date added");
              },
              child: Text('Date added'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                updateOrderType("Update added");
              },
              child: Text('Update Date'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        );
      },
    );
  }

  ListView _buildPlaylistList(List<UserPlaylist> playlists) {
    if (widget.orderType == "Title") {
      playlists.sort((a, b) => a.name!.compareTo(b.name!));
    } else if (widget.orderType == "Date added") {
      playlists.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
    } else {
      playlists.sort((a, b) => a.updatedAt!.compareTo(b.updatedAt!));
    }
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

class PlayListSearchDelegate extends SearchDelegate<String> {
  PlayListSearchDelegate()
      : super(
          searchFieldLabel: "Search playlist...",
          searchFieldStyle: TextStyle(color: Colors.black), // Text color
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.red, // Cursor color
      ),
      inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.grey), // Hint text color
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide.none // Underline when focused
              ),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none)),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocBuilder<PlaylistBloc, PlaylistState>(
      builder: (context, playlistState) {
        if (playlistState is PlaylistLoading) {
          return Skeletonizer(
              enabled: true, child: _buildPlaylistList(FakeData.playlists));
        } else if (playlistState is PlaylistGetFailure) {
          return Center(
            child: Text(playlistState.message),
          );
        } else if (playlistState is PlaylistGetSuccess) {
          final List<UserPlaylist> filteredPlaylists = playlistState.playlists
              .where((playlist) =>
                  playlist.name!.toLowerCase().contains(query.toLowerCase()))
              .toList();
          if (filteredPlaylists.isEmpty) {
            return Center(
              child: Text(
                "No playlist found",
                style: TextStyle(
                    color: AppColor.inkGreyDark, fontWeight: FontWeight.bold),
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "Search results",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                _buildPlaylistList(filteredPlaylists),
                const SizedBox(height: 200),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return buildResults(context);
    }
    return BlocBuilder<PlaylistBloc, PlaylistState>(
      builder: (context, playlistState) {
        if (playlistState is PlaylistLoading) {
          return Skeletonizer(
              enabled: true, child: _buildPlaylistList(FakeData.playlists));
        } else if (playlistState is PlaylistGetFailure) {
          return Center(
            child: Text(playlistState.message),
          );
        } else if (playlistState is PlaylistGetSuccess) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "Your playlists",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                _buildPlaylistList(playlistState.playlists),
                const SizedBox(height: 200),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildPlaylistList(List<UserPlaylist> playlists) {
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
