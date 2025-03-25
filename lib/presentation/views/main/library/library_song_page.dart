import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/data/models/track_in_library.dart';
import 'package:sound_sphere/presentation/blocs/library/library_bloc.dart';
import 'package:sound_sphere/presentation/views/main/library/components/library_header.dart';
import 'package:sound_sphere/presentation/views/main/library/components/search_bar_delegate.dart';
import 'package:sound_sphere/presentation/widgets/button/primary_button.dart';
import 'package:sound_sphere/presentation/widgets/track/track_item.dart';
import 'package:diacritic/diacritic.dart';

class LibrarySongPage extends StatefulWidget {
  const LibrarySongPage({super.key});

  @override
  State<LibrarySongPage> createState() => _LibrarySongPageState();
}

class _LibrarySongPageState extends State<LibrarySongPage> {
  List<Track> allTracks = [];
  List<TrackInLibrary> favoriteTracks = [];
  final ScrollController _scrollController = ScrollController();
  bool isScrolled = false;
  String currentSort = "All songs";
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    if (context.read<LibraryBloc>().state is! TrackLibraryLoaded) {
      context.read<LibraryBloc>().add(GetTrackLibraryRequest());
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
    return BlocListener<LibraryBloc, LibraryState>(
      listener: (context, state) {
        if (state is RemoveTrackFromLibSuccess) {
          context.read<LibraryBloc>().add(GetTrackLibraryRequest());
        } else if (state is RemoveTrackFromLibError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to remove track: ${state.message}")),
          );
        }
      },
      child: Scaffold(
        body: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                LibraryPlaylistHeader(
                  isScrolled: isScrolled,
                  title: "Songs",
                  onTap: () {
                    _showOptionMenu();
                  },
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SearchBarDelegate(
                      onTap: () => showSearch(
                          context: context,
                          delegate: SongLibrarySearchDelegate())),
                ),
              ];
            },
            body: SingleChildScrollView(
                child: Column(children: [
              _buildPlaySection(),
              BlocBuilder<LibraryBloc, LibraryState>(
                builder: (context, state) {
                  if (state is TrackLibraryLoaded) {
                    allTracks = state.tracks;
                    favoriteTracks = state.favoriteTracks;
                    List<Track> tracks = state.tracks;
                    if (currentSort == "Date added") {
                      tracks = state.tracks.reversed.toList();
                    } else if (currentSort == "Title") {
                      tracks.sort((a, b) => a.title.compareTo(b.title));
                    } else if (currentSort == "Artist") {
                      tracks.sort((a, b) => a.artist.compareTo(b.artist));
                    }
                    return _buildSongList(tracks, state.favoriteTracks);
                  } else if (state is GetFavoriteTracksRequestSuccess) {
                    return _buildSongList(state.tracks, state.favoriteTracks);
                  } else if (state is LibraryLoading) {
                    return Skeletonizer(
                        enabled: true,
                        child: _buildSongList(FakeData.gnxTracks, []));
                  } else {
                    return Container();
                  }
                },
              ),
              Container(
                color: Colors.white,
                height: 150,
              ),
            ]))),
      ),
    );
  }

  void _showOptionMenu() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('Options'),
          message: const Text('How you want your track order?'),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                if (currentSort == "All songs") {
                  Navigator.of(context).pop();
                  return;
                } else {
                  Navigator.of(context).pop();
                  setState(() {
                    currentSort = "All songs";
                  });
                }
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (currentSort == "All songs")
                        const Icon(Icons.check, color: Colors.blue),
                      const SizedBox(width: 10),
                      const Text('All songs'),
                    ],
                  ),
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                if (currentSort == "Favorites") {
                  Navigator.of(context).pop();
                  return;
                } else {
                  Navigator.of(context).pop();
                  setState(() {
                    currentSort = "Favorites";
                  });
                }
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (currentSort == "Favorites")
                        const Icon(Icons.check, color: Colors.blue),
                      const SizedBox(width: 10),
                      const Text('Favorites'),
                    ],
                  ),
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                if (currentSort == "Date added") {
                  Navigator.of(context).pop();
                  return;
                } else {
                  Navigator.of(context).pop();
                  setState(() {
                    currentSort = "Date added";
                  });
                }
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (currentSort == "Date added")
                        const Icon(Icons.check, color: Colors.blue),
                      const SizedBox(width: 10),
                      const Text('Date added'),
                    ],
                  ),
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                if (currentSort == "Title") {
                  Navigator.of(context).pop();
                  return;
                } else {
                  Navigator.of(context).pop();
                  setState(() {
                    currentSort = "Title";
                  });
                }
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (currentSort == "Title")
                        const Icon(Icons.check, color: Colors.blue),
                      const SizedBox(width: 10),
                      const Text('Title'),
                    ],
                  ),
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                if (currentSort == "Artist") {
                  Navigator.of(context).pop();
                  return;
                } else {
                  Navigator.of(context).pop();
                  setState(() {
                    currentSort = "Artist";
                  });
                }
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (currentSort == "Artist")
                        const Icon(Icons.check, color: Colors.blue),
                      const SizedBox(width: 10),
                      const Text('Artist'),
                    ],
                  ),
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              isDestructiveAction: true,
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  ListView _buildSongList(
      List<Track> tracks, List<TrackInLibrary> libraryTracks) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: currentSort == "Favorites"
            ? tracks
                .where((track) => libraryTracks
                    .any((libraryTrack) => libraryTrack.id == track.id))
                .length
            : tracks.length,
        itemBuilder: (context, index) {
          List<Track> filteredTracks = tracks;
          if (currentSort == "Favorites") {
            filteredTracks = tracks
                .where((track) => libraryTracks
                    .any((libraryTrack) => libraryTrack.id == track.id))
                .toList();
          }
          final isFavorite = libraryTracks.any(
              (libraryTrack) => libraryTrack.id == filteredTracks[index].id);
          return Padding(
            padding: EdgeInsets.only(
              left: isFavorite ? 0 : 10,
              right: 10,
            ),
            child: Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    flex: 2,
                    onPressed: (BuildContext context) {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoActionSheet(
                            title: const Text('Confirm'),
                            message: const Text(
                                'Are you sure you want to remove this track?'),
                            actions: [
                              CupertinoActionSheetAction(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  context.read<LibraryBloc>().add(
                                        RemoveTrackFromLibRequest(
                                          tracks[index].id!,
                                        ),
                                      );
                                },
                                isDestructiveAction: true,
                                child: const Text('Remove'),
                              ),
                              CupertinoActionSheetAction(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    foregroundColor: AppColor.primaryColor,
                    icon: Icons.delete,
                  ),
                ],
              ),
              child: TrackItem(
                track: tracks[index],
                isSliable: false,
                isFavorite: isFavorite,
              ),
            ),
          );
        });
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

class SongLibrarySearchDelegate extends SearchDelegate<String> {
  SongLibrarySearchDelegate()
      : super(
          searchFieldLabel: "Search song in library",
          searchFieldStyle: TextStyle(color: Colors.black), // Text colo
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
    return BlocBuilder<LibraryBloc, LibraryState>(
      builder: (context, libState) {
        if (libState is LibraryLoading) {
          return Skeletonizer(
              enabled: true, child: _buildSongList(FakeData.gnxTracks, []));
        } else if (libState is TrackLibraryError) {
          return Center(
            child: Text(libState.message),
          );
        } else if (libState is TrackLibraryLoaded) {
          final List<Track> tracks = libState.tracks
              .where((track) => removeDiacritics(track.title.toLowerCase())
                  .contains(removeDiacritics(query.toLowerCase())))
              .toList();
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
                _buildSongList(tracks, libState.favoriteTracks),
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
    return BlocBuilder<LibraryBloc, LibraryState>(
      builder: (context, libState) {
        if (libState is LibraryLoading) {
          return Skeletonizer(
              enabled: true, child: _buildSongList(FakeData.gnxTracks, []));
        } else if (libState is TrackLibraryError) {
          return Center(
            child: Text(libState.message),
          );
        } else if (libState is TrackLibraryLoaded) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "Your songs",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                _buildSongList(libState.tracks, libState.favoriteTracks),
                const SizedBox(height: 200),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  ListView _buildSongList(
      List<Track> tracks, List<TrackInLibrary> libraryTracks) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: tracks.length,
        itemBuilder: (context, index) {
          final isFavorite = libraryTracks
              .any((libraryTrack) => libraryTrack.id == tracks[index].id);
          return Padding(
            padding: EdgeInsets.only(
              left: isFavorite ? 0 : 10,
              right: 10,
            ),
            child: Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    flex: 2,
                    onPressed: (BuildContext context) {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoActionSheet(
                            title: const Text('Confirm'),
                            message: const Text(
                                'Are you sure you want to remove this track?'),
                            actions: [
                              CupertinoActionSheetAction(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  context.read<LibraryBloc>().add(
                                        RemoveTrackFromLibRequest(
                                          tracks[index].id!,
                                        ),
                                      );
                                },
                                isDestructiveAction: true,
                                child: const Text('Remove'),
                              ),
                              CupertinoActionSheetAction(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    foregroundColor: AppColor.primaryColor,
                    icon: Icons.delete,
                  ),
                ],
              ),
              child: TrackItem(
                track: tracks[index],
                isSliable: false,
                isFavorite: isFavorite,
              ),
            ),
          );
        });
  }
}
