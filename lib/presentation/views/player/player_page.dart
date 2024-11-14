import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/controller/player_controller.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/song.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/presentation/views/player/components/current_song.dart';
import 'package:sound_sphere/presentation/views/player/components/mini_current_song.dart';
import 'package:sound_sphere/presentation/views/player/components/non_sync_lyrics.dart';
import 'package:sound_sphere/presentation/views/player/components/player_play_control.dart';
import 'package:sound_sphere/presentation/views/player/components/playlist_function.dart';
import 'package:sound_sphere/presentation/views/player/components/playlist_songlist.dart';
import 'package:sound_sphere/presentation/views/player/components/song_duration.dart';

class PlayerPage extends StatefulWidget {
  PlayerController playerController;
  PlayerPage({super.key, required this.playerController});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool _isFavorite = false;
  bool _isShuffle = false;
  bool _isRepeat = false;
  final bool _isLoop = false;
  bool _isInfinity = false;

  // handle menu state
  bool _isShowPlaylist = false;
  bool _isShowLyrics = false;
  bool _isInMenu = false;

  // late Song currentSong;
  // late int currentSongIndex;

  // handle scrolling lyrics
  final ScrollController _lyricsScrollController = ScrollController();
  bool _isScrollingLyrics = false;

  @override
  void initState() {
    super.initState();
    // handle scrolling lyrics

    _lyricsScrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _lyricsScrollController.removeListener(_onScroll);
    _lyricsScrollController.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background image
          ..._buildPlayerBackground(),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 70),
                Center(
                  child: Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(5),
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
                        top:
                            _isInMenu ? -MediaQuery.of(context).size.height : 0,
                        child: AnimatedOpacity(
                          opacity: _isInMenu ? 0.0 : 1.0,
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeInOut,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: CurrentSong(
                                playerController: widget.playerController,
                                isFavorite: _isFavorite),
                          ),
                        ),
                      ),
                      // Playlist with smooth fade-in and position animation
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeInOut,
                        top: _isInMenu ? 0 : MediaQuery.of(context).size.height,
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
            bottom: !_isScrollingLyrics ? 30 : -150, // Adjust this as needed
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
                  playerController: widget.playerController,
                  isFavorite: _isFavorite)),
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
                          child: PlaylistFunction(),
                        ),
                        Expanded(
                          child: PlaylistSonglist(
                              playerController: widget.playerController),
                        ),
                        const SizedBox(height: 350),
                      ],
                    )
                  : _isShowLyrics
                      ? Padding(
                          key: const ValueKey('lyrics'),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: NonSyncLyrics(
                              lyricsScrollController: _lyricsScrollController,
                              playerController: widget.playerController),
                        )
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
          SongDuration(
              playerController: widget.playerController, isSliding: isSliding),
          const SizedBox(height: 30),
          // ...buildSongControl(),
          PlayerPlayControl(playerController: widget.playerController),
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
