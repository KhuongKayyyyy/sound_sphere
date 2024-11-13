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

// To move to the previous song in the playlist

  void _togglePlayPause() {
    if (widget.playerController.isPlaying) {
      widget.playerController.pause();
    } else {
      widget.playerController.play();
    }
  }

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
                            child: _buildSongInfo(),
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
                  ? _buildSongPlayControl()
                  : Container(), // Hide when not needed
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSongInfo() {
    return Column(
      key: const ValueKey('songInfo'),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 90),
          child: Center(
            child: ValueListenableBuilder(
              valueListenable: widget.playerController.isPlayingNotifier,
              builder: (context, isPlaying, child) => AnimatedScale(
                scale: isPlaying ? 1.3 : 1.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: CupertinoContextMenu(
                  actions: [
                    CupertinoContextMenuAction(
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Go to Album',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(FakeData.albums[0].title,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const Spacer(),
                          Image.asset(
                            AppIcon.stack,
                            scale: 20,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        context.pushNamed(Routes.albumDetail, extra: "albumId");
                      },
                    ),
                    CupertinoContextMenuAction(
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Go to Artist',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(FakeData.artists.first.name,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const Spacer(),
                          Image.asset(
                            AppIcon.micro,
                            scale: 20,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        context.pushNamed(Routes.artistDetail,
                            extra: "artistId");
                      },
                    ),
                    CupertinoContextMenuAction(
                      child: const Text(
                        'Share',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {},
                    ),
                  ],
                  child: ValueListenableBuilder(
                    valueListenable:
                        widget.playerController.currentSongNotifier,
                    builder: (context, currentSong, child) => Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        boxShadow: isPlaying
                            ? [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                ),
                              ]
                            : [],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: Stack(
                          children: [
                            // Scaled image
                            SizedBox(
                              height: 250,
                              width: 250,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: AnimatedBuilder(
                                  animation: widget.playerController,
                                  builder: (context, child) {
                                    return Image.network(
                                      widget.playerController
                                          .getCurrentSong()
                                          .imgURL,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                            ),
                            // Favorite button
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isFavorite = !_isFavorite;
                                      _showFavoriteSnackBar();
                                    });
                                  },
                                  icon: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    transitionBuilder: (Widget child,
                                        Animation<double> animation) {
                                      return ScaleTransition(
                                          scale: animation, child: child);
                                    },
                                    child: _isFavorite
                                        ? Icon(
                                            Icons.favorite,
                                            color: AppColor.primaryColor,
                                            key: const ValueKey('favorite'),
                                          )
                                        : const Icon(
                                            Icons.favorite_outline_rounded,
                                            color: Colors.white,
                                            key: ValueKey('not_favorite'),
                                          ),
                                  ),
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                            // More button
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: CupertinoContextMenu(
                                actions: [
                                  CupertinoContextMenuAction(
                                    child: const Text('Add to playlist'),
                                    onPressed: () {},
                                  ),
                                  CupertinoContextMenuAction(
                                    child: const Text('Share'),
                                    onPressed: () {},
                                  ),
                                ],
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                  child: const Icon(
                                    Icons.more_horiz_rounded,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            _showPopupMenu();
          },
          child: Column(
            children: [
              AnimatedBuilder(
                animation: widget.playerController,
                builder: (context, child) => Text(
                  widget.playerController.getCurrentSong().title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              AnimatedBuilder(
                animation: widget.playerController,
                builder: (context, child) => Text(
                  widget.playerController.getCurrentSong().artistName,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerFunction() {
    Widget buildSmallCurrentSong() {
      return Row(
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: AnimatedBuilder(
                    animation: widget.playerController,
                    builder: (context, child) {
                      return Image.network(
                          widget.playerController.getCurrentSong().imgURL,
                          fit: BoxFit.cover);
                    })),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 180,
                child: AnimatedBuilder(
                    animation: widget.playerController,
                    builder: (context, child) {
                      return Text(
                        widget.playerController.getCurrentSong().title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      );
                    }),
              ),
              Text(
                widget.playerController.getCurrentSong().artistName,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _isFavorite = !_isFavorite;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.3),
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: _isFavorite
                        ? Icon(
                            Icons.favorite,
                            color: AppColor.primaryColor,
                            key: const ValueKey('favorite'),
                          )
                        : const Icon(
                            Icons.favorite_border_rounded,
                            color: Colors.white,
                            key: ValueKey('not_favorite'),
                          ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.3),
                  ),
                  child:
                      const Icon(Icons.more_horiz_rounded, color: Colors.white),
                ),
              ),
            ],
          )
        ],
      );
    }

    Widget buildPlaylistFunction() {
      return Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Playing next",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 20)),
              Text("From SoundSphere",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
            ],
          ),
          const Spacer(),
          // Shuffle, Repeat, Infinity
          InkWell(
            onTap: () {
              // Handle shuffle action
              setState(() {
                _isShuffle = !_isShuffle;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: _isShuffle
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(0.7),
                    )
                  : null,
              child: Image.asset(
                AppIcon.shuffle,
                scale: 20,
                color:
                    !_isShuffle ? Colors.white : Colors.black.withOpacity(0.4),
              ),
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () => setState(() {
              _isRepeat = !_isRepeat;
            }),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: _isRepeat || _isLoop
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(0.7),
                    )
                  : null,
              child: !_isRepeat
                  ? Image.asset(
                      AppIcon.repeat,
                      scale: 20,
                      color: Colors.white,
                    )
                  : Image.asset(
                      AppIcon.repeat_once,
                      scale: 20,
                      color: Colors.white,
                    ),
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () => setState(() {
              _isInfinity = !_isInfinity;
            }),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: _isInfinity
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(0.7),
                    )
                  : null,
              child: Image.asset(
                AppIcon.infinity,
                scale: 20,
                color:
                    !_isInfinity ? Colors.white : Colors.black.withOpacity(0.4),
              ),
            ),
          )
        ],
      );
    }

    void onReorder(int oldIndex, int newIndex) {
      setState(() {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        final song =
            widget.playerController.getPlaylistSongs().removeAt(oldIndex);
        widget.playerController.getPlaylistSongs().insert(newIndex, song);
      });
    }

    void removeSong(Song song) {
      setState(() {
        widget.playerController.getPlaylistSongs().remove(song);
      });
    }

    Widget buildPlayListSongList() {
      return ReorderableListView(
        proxyDecorator: (Widget child, int index, Animation<double> animation) {
          return Material(
            color: Colors.black.withOpacity(0.2),
            child: child,
          );
        },
        onReorder: onReorder,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        buildDefaultDragHandles: false,
        children: [
          for (var song in widget.playerController.getPlaylistSongs())
            Dismissible(
              key: ValueKey(song.title),
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.red,
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                removeSong(song);
              },
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            song.imgURL,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            song.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            song.artistName,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      ReorderableDragStartListener(
                        index: widget.playerController
                            .getPlaylistSongs()
                            .indexOf(song),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      );
    }

    Widget buildPlayetSongLyricsNoSync() {
      return SingleChildScrollView(
        controller: _lyricsScrollController,
        child: SizedBox(
            width: double.infinity,
            child: AnimatedBuilder(
              animation: widget.playerController,
              builder: (context, builder) => Text(
                widget.playerController.getCurrentSong().lyrics,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontWeight: FontWeight.w900,
                    height: 1.5,
                    fontSize: 35),
              ),
            )),
      );
    }

    // player function container
    return Container(
      key: const ValueKey('playlist'),
      // color: Colors.white,
      child: Column(
        children: [
          // current song
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: buildSmallCurrentSong()),
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
                          child: buildPlaylistFunction(),
                        ),
                        Expanded(
                          child: buildPlayListSongList(),
                        ),
                        const SizedBox(height: 350),
                      ],
                    )
                  : _isShowLyrics
                      ? Padding(
                          key: const ValueKey('lyrics'),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: buildPlayetSongLyricsNoSync(),
                        )
                      : Container(), // Placeholder or fallback widget if neither is true
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSongPlayControl() {
    bool isSliding = false;
    List<Widget> buildSongDuration() {
      return [
        SizedBox(
            width: double.infinity,
            height: isSliding ? 10 : 5, // Scale up height when sliding
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.white,
                  thumbColor: Colors.white,
                  thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: isSliding ? 10.0 : 6.0),
                  overlayShape: RoundSliderOverlayShape(
                      overlayRadius: isSliding ? 20.0 : 0),
                ),
                child: AnimatedBuilder(
                  animation: widget.playerController,
                  builder: (context, child) => Slider(
                    value: widget.playerController
                        .getCurrentPosition()
                        .inSeconds
                        .toDouble(),
                    max: widget.playerController
                        .getTotalDuration()
                        .inSeconds
                        .toDouble(),
                    onChanged: (value) async {
                      widget.playerController
                          .seekTo(Duration(seconds: value.toInt()));
                    },
                    onChangeStart: (value) {
                      setState(() {
                        isSliding = true; // Start scaling and color change
                      });
                    },
                    onChangeEnd: (value) {
                      setState(() {
                        isSliding = false; // End scaling and color change
                      });
                    },
                  ),
                ),
              ),
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            children: [
              AnimatedBuilder(
                  animation: widget.playerController,
                  builder: (context, child) {
                    return Text(
                      widget.playerController.getCurrentPositionString(),
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.bold),
                    );
                  }),
              const Spacer(),
              AnimatedBuilder(
                  animation: widget.playerController,
                  builder: (context, child) {
                    return Text(
                      widget.playerController.getRemainingDurationString(),
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.bold),
                    );
                  }),
            ],
          ),
        ),
      ];
    }

    List<Widget> buildSongControl() {
      return [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  // setState(() {
                  //   _moveToPreviousSong();
                  // });
                  widget.playerController.moveToPreviousSong();
                },
                child: Image.asset(
                  AppIcon.play_previous,
                  scale: 15,
                  color: Colors.white,
                ),
              ),
              InkWell(
                  onTap: () {
                    _togglePlayPause();
                  },
                  child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: ValueListenableBuilder<bool>(
                        valueListenable:
                            widget.playerController.isPlayingNotifier,
                        builder: (context, isPlaying, child) {
                          return InkWell(
                            onTap: () {
                              _togglePlayPause();
                            },
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return ScaleTransition(
                                    scale: animation, child: child);
                              },
                              child: !isPlaying
                                  ? Image.asset(
                                      AppIcon.play,
                                      key: const ValueKey('play'),
                                      scale: 15,
                                      color: Colors.white,
                                    )
                                  : Image.asset(
                                      AppIcon.pause,
                                      key: const ValueKey('pause'),
                                      scale: 15,
                                      color: Colors.white,
                                    ),
                            ),
                          );
                        },
                      ))),
              InkWell(
                onTap: () {
                  // setState(() {
                  //   _moveToNextSong();
                  // });
                  widget.playerController.moveToNextSong();
                },
                child: Image.asset(
                  AppIcon.play_next,
                  scale: 15,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ];
    }

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
          ...buildSongDuration(),
          const SizedBox(height: 30),
          ...buildSongControl(),
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
                height: MediaQuery.of(context).size.height - 300,
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

  void _showFavoriteSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ]),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
                height: 50,
                width: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AnimatedBuilder(
                      animation: widget.playerController,
                      builder: (context, child) {
                        return Image.network(
                            widget.playerController.getCurrentSong().imgURL,
                            fit: BoxFit.cover);
                      }),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                    animation: widget.playerController,
                    builder: (context, child) {
                      return Text(
                          widget.playerController.getCurrentSong().title,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold));
                    }),
                Text("Loved",
                    style: TextStyle(
                      color: AppColor.primaryColor,
                    ))
              ],
            ),
            Icon(Icons.favorite, color: AppColor.primaryColor),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 200,
          right: 60,
          left: 60),
      elevation: 0,
    ));
  }

  void _showPopupMenu() {}
}
