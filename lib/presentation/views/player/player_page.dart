import 'package:flutter/foundation.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/controller/player_controller.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/blocs/library/library_bloc.dart';
import 'package:sound_sphere/presentation/views/player/components/current_song.dart';
import 'package:sound_sphere/presentation/views/player/components/history_playlist_player.dart';
import 'package:sound_sphere/presentation/views/player/components/infinite_playlist.dart';
import 'package:sound_sphere/presentation/views/player/components/mini_current_song.dart';
import 'package:sound_sphere/presentation/views/player/components/non_sync_lyrics.dart';
import 'package:sound_sphere/presentation/views/player/components/player_play_control.dart';
import 'package:sound_sphere/presentation/views/player/components/playlist_function.dart';
import 'package:sound_sphere/presentation/views/player/components/playlist_song_list.dart';
import 'package:sound_sphere/presentation/views/player/components/song_duration.dart';
import 'package:sound_sphere/presentation/views/player/components/synced_lyric.dart';

class PlayerPage extends StatefulWidget {
  final PlayerController playerController = PlayerController();
  PlayerPage({super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  bool _isFavorite = false;

  // handle menu state
  bool _isShowPlaylist = false;
  bool _isShowLyrics = false;
  bool _isInMenu = false;

  // handle scrolling lyrics
  final ScrollController _lyricsScrollController = ScrollController();
  bool _isScrollingLyrics = false;

  // handle scrolling playlists
  final ScrollController _playlistScrollController = ScrollController();
  bool _showHistoryPlaylist = true;

  @override
  void initState() {
    super.initState();
    // _loadState();
    _lyricsScrollController.addListener(_onScroll);
    _playlistScrollController.addListener(_onPlaylistScroll);
    context
        .read<LibraryBloc>()
        .add(CheckIfTrackIsFavorite(PlayerController().getCurrentSong().id!));
  }

  // Future<void> _loadState() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   if (mounted) {
  //     setState(() {
  //       _isShowLyrics = prefs.getBool('isShowLyric') ?? false;
  //       _isShowPlaylist = prefs.getBool('isShowPlaylist') ?? false;
  //     });
  //   }
  // }

  // Future<void> _saveState() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('isShowLyric', _isShowLyrics);
  //   await prefs.setBool('isShowPlaylist', _isShowPlaylist);
  // }

  @override
  void dispose() {
    // _saveState();
    _lyricsScrollController.removeListener(_onScroll);
    _lyricsScrollController.dispose();

    _playlistScrollController.removeListener(_onPlaylistScroll);
    _playlistScrollController.dispose();

    super.dispose();
  }

  // handle player state
  void _onScroll() {
    if (_lyricsScrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (!_isScrollingLyrics) {
        setState(() {
          _isScrollingLyrics = true;
        });
      }
    } else if (_lyricsScrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (_isScrollingLyrics) {
        setState(() {
          _isScrollingLyrics = false;
        });
      }
    }
  }

  void _onPlaylistScroll() {
    if (kDebugMode) {
      print('Scroll position: ${_playlistScrollController.position.pixels}');
    }
    if (kDebugMode) {
      print(
          'Scroll direction: ${_playlistScrollController.position.userScrollDirection}');
    }

    if (_isInMenu && _isShowPlaylist) {
      if (_playlistScrollController.position.pixels <= 10 &&
          _playlistScrollController.position.userScrollDirection ==
              ScrollDirection.forward) {
        if (kDebugMode) {
          print('Showing history playlist');
        }
        setState(() {
          _showHistoryPlaylist = true;
        });
      }
      if (_playlistScrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (kDebugMode) {
          print('Hiding history playlist');
        }
        if (_showHistoryPlaylist) {
          setState(() {
            _showHistoryPlaylist = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBloc, LibraryState>(
      builder: (context, state) {
        if (state is CheckTrackFavoriteSuccess) {
          // widget.playerController.getCurrentSong().isFavorite =
          //     state.isFavorite;
          _isFavorite = state.isFavorite;
        }
        return Scaffold(
          body: GestureDetector(
            onVerticalDragUpdate: (details) {
              if (details.primaryDelta! > 10) {
                // Drag distance threshold
                context.pop(); // Pop the context when dragging down
              }
            },
            child: Stack(
              children: [
                // Background image
                ..._buildPlayerBackground(),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 70),
                      Center(
                        child: GestureDetector(
                          onTap: () => context.pop(),
                          child: Container(
                            height: 5,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Animated section for song info and playlist
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: _isScrollingLyrics
                            ? MediaQuery.of(context).size.height - 85
                            : 500, // Adjust heights here if necessary
                        child: Stack(
                          children: [
                            // Song Info with smoother fade-out effect
                            AnimatedPositioned(
                              duration: const Duration(milliseconds: 700),
                              curve: Curves.easeInOut,
                              top: _isInMenu
                                  ? -MediaQuery.of(context).size.height
                                  : 0,
                              child: AnimatedOpacity(
                                opacity: _isInMenu ? 0.0 : 1.0,
                                duration: const Duration(milliseconds: 700),
                                curve: Curves.easeInOut,
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CurrentSong(
                                      isFavorite: _isFavorite,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Playlist with smooth fade-in and position animation
                            AnimatedPositioned(
                              duration: const Duration(milliseconds: 700),
                              curve: Curves.easeInOut,
                              top: _isInMenu
                                  ? 0
                                  : MediaQuery.of(context).size.height,
                              child: AnimatedOpacity(
                                opacity: _isInMenu ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 700),
                                curve: Curves.easeInOut,
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: _buildPlayerFunction(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  bottom:
                      !_isScrollingLyrics ? 30 : -150, // Adjust this as needed
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: !_isScrollingLyrics
                        ? 1.0
                        : 0.0, // Fully visible when not scrolling lyrics
                    curve: Curves.easeInOut,
                    child: !_isScrollingLyrics
                        ? _buildPlayerPlayControl()
                        : Container(), // Hide when not needed
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlayerFunction() {
    // player function container
    return Container(
      key: const ValueKey('playlist'),
      // color: Colors.white,
      child: Column(
        children: [
          // current song
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: MiniCurrentSong(
                isFavorite: _isFavorite,
                onImageTap: () => setState(() {
                  _isInMenu = false;
                  _isShowLyrics = false;
                  _isShowPlaylist = false;
                }),
              )),
          // playlist
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: _isShowPlaylist
                  ? Column(
                      key: const ValueKey('playlist'),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 10),
                          child: PlaylistFunction(
                            showHistory: _showHistoryPlaylist,
                            onInfinity: () {
                              setState(() {
                                PlayerController().isInfinity =
                                    !PlayerController().isInfinity;
                              });
                            },
                            onShuffle: () {
                              setState(() {
                                PlayerController().isShuffle =
                                    !PlayerController().isShuffle;
                              });
                              widget.playerController.shufflePlaylist();
                            },
                            onShowHistory: () => setState(() {
                              _showHistoryPlaylist = !_showHistoryPlaylist;
                            }),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                AnimatedCrossFade(
                                  duration: const Duration(milliseconds: 700),
                                  firstChild: HistoryPlaylistPlayer(
                                    key: const ValueKey("HistoryPlaylist"),
                                  ),
                                  secondChild: PlaylistSonglist(
                                    key: const ValueKey("PlaylistSonglist"),
                                    // songList: PlayerController().isShuffle
                                    //     ? widget.playerController
                                    //         .getShuffledPlaylistSongs()
                                    //     : widget.playerController
                                    //         .getPlaylistSongs(),
                                    scrollController: _playlistScrollController,
                                  ),
                                  crossFadeState: !_showHistoryPlaylist
                                      ? CrossFadeState.showFirst
                                      : CrossFadeState.showSecond,
                                ),
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 500),
                                  transitionBuilder: (Widget child,
                                      Animation<double> animation) {
                                    return FadeTransition(
                                        opacity: animation, child: child);
                                  },
                                  child: PlayerController().isInfinity
                                      ? InfinitePlaylist(
                                          key: const ValueKey(
                                              'infinitePlaylist'))
                                      : Container(key: const ValueKey('empty')),
                                ),
                                const SizedBox(height: 50),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 350),
                      ],
                    )
                  : _isShowLyrics
                      ? Padding(
                          key: const ValueKey('lyrics'),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          // child: NonSyncLyrics(
                          //   lyricsScrollController: _lyricsScrollController,
                          // ),
                          child: PlayerController()
                                      .getCurrentSong()
                                      .album
                                      .title ==
                                  FakeData.gnx.title
                              ? SyncedLyric(
                                  track: PlayerController().getCurrentSong(),
                                  lyricsScrollController:
                                      _lyricsScrollController,
                                )
                              : NonSyncLyrics(
                                  lyricsScrollController:
                                      _lyricsScrollController,
                                  trackId:
                                      PlayerController().getCurrentSong().id!,
                                ))
                      : Container(), // Placeholder or fallback widget if neither is true
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerPlayControl() {
    bool isSliding = false;
    Widget buildSongUltility() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          !_isShowLyrics
              ? InkWell(
                  onTap: () {
                    setState(() {
                      if (_isInMenu == true) {
                        _isShowPlaylist = !_isShowPlaylist;
                        _isShowLyrics = !_isShowLyrics;
                      } else {
                        _isInMenu = !_isInMenu;
                        _isShowLyrics = !_isShowLyrics;
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent,
                    ),
                    child: Image.asset(
                      AppIcon.lyrics,
                      scale: 20,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                )
              : InkWell(
                  onTap: () {
                    setState(() {
                      _isInMenu = !_isInMenu;
                      _isShowLyrics = !_isShowLyrics;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(0.7),
                    ),
                    child: Image.asset(
                      AppIcon.lyrics,
                      scale: 20,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ),
          InkWell(
            onTap: () {}, // Airplay functionality
            child: Image.asset(
              AppIcon.airplay,
              scale: 20,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
          IconButton(
            onPressed: () {}, // Timer functionality
            icon: Icon(
              Icons.timer_sharp,
              color: Colors.white.withOpacity(0.7),
              size: 35,
            ),
          ),
          !_isShowPlaylist
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      if (_isInMenu == true) {
                        _isShowLyrics = !_isShowLyrics;
                        _isShowPlaylist = !_isShowPlaylist;
                      } else {
                        _isInMenu = !_isInMenu;
                        _isShowPlaylist = !_isShowPlaylist;
                      }
                    });
                  },
                  icon: Icon(
                    Icons.list_rounded,
                    color: Colors.white.withOpacity(0.7),
                    size: 35,
                  ),
                )
              : Container(
                  // padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(0.7),
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _isInMenu = !_isInMenu;
                        _isShowPlaylist = !_isShowPlaylist;
                      });
                    },
                    icon: Icon(
                      Icons.list_rounded,
                      color: Colors.black.withOpacity(0.7),
                      size: 35,
                    ),
                  ),
                ),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SongDuration(isSliding: isSliding),
          const SizedBox(height: 30),
          // ...buildSongControl(),
          PlayerPlayControl(),
          const SizedBox(height: 50),
          buildSongUltility(),
        ],
      ),
    );
  }

  List<Widget> _buildPlayerBackground() {
    return [
      AnimatedBuilder(
          animation: widget.playerController,
          builder: (context, child) => SizedBox(
                height: MediaQuery.of(context).size.height - 250,
                child: Image.network(
                    widget.playerController.getCurrentSong().imgURL,
                    fit: BoxFit.cover),
              )),
      Positioned.fill(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10000, sigmaY: 10000),
          child: Container(
            color: Colors.black.withOpacity(0.2),
          ),
        ),
      )
    ];
  }
}
