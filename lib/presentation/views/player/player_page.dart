import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/song.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  Song currentSong = FakeData.songs[2];
  List<Song> _playlistSongs =
      List.from(FakeData.songs.take(10)); // Initialize with 10 songs
  bool _isFavorite = false;
  bool _isPlaying = false;
  bool _isShowPlaylist = false;
  bool _isShuffle = false;
  bool _isRepeat = false;
  bool _isLoop = false;
  bool _isInfinity = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  duration: const Duration(milliseconds: 400),
                  height: 500, // Adjust heights here if necessary
                  child: Stack(
                    children: [
                      // Song Info with smoother fade-out effect
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeInOut,
                        top: _isShowPlaylist
                            ? -MediaQuery.of(context).size.height
                            : 0,
                        child: AnimatedOpacity(
                          opacity: _isShowPlaylist ? 0.0 : 1.0,
                          duration: const Duration(milliseconds: 300),
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
                        top: _isShowPlaylist
                            ? 0
                            : MediaQuery.of(context).size.height,
                        child: AnimatedOpacity(
                          opacity: _isShowPlaylist ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: _buildPlayerPlaylist(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
                _buildSongPlayControl(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSongInfo() {
    return Column(
      key: const ValueKey('songInfo'),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 70),
          child: Center(
            child: AnimatedScale(
              scale: _isPlaying ? 1.3 : 1.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  boxShadow: _isPlaying
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 5,
                          ),
                        ]
                      : [],
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(currentSong.imgURL),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
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
                            });
                          },
                          icon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
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
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.7),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_horiz_rounded,
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          currentSong.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          currentSong.artistName,
          style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildPlayerPlaylist() {
    Widget buildPlaylistCurrentSong() {
      return Row(
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  currentSong.imgURL,
                  fit: BoxFit.cover,
                )),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentSong.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                currentSong.artistName,
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
        final song = _playlistSongs.removeAt(oldIndex);
        _playlistSongs.insert(newIndex, song);
      });
    }

    void _removeSong(Song song) {
      setState(() {
        _playlistSongs.remove(song);
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
          for (var song in _playlistSongs)
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
              direction: DismissDirection.endToStart, // Enable swipe left only
              onDismissed: (direction) {
                // Handle remove song from playlist
                _removeSong(song); // Define this function to update your list
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
                        index: _playlistSongs.indexOf(song),
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

    // playlist container
    return Container(
      key: const ValueKey('playlist'),
      // color: Colors.white,
      child: Column(
        children: [
          // current song
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: buildPlaylistCurrentSong()),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: buildPlaylistFunction(),
          ),
          // playlist
          Expanded(
            child: buildPlayListSongList(),
          ),
          const SizedBox(height: 350),
        ],
      ),
    );
  }

  Widget _buildSongPlayControl() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            height: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: LinearProgressIndicator(
                value: 0.2,
                backgroundColor: Colors.white.withOpacity(0.5),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Row(
              children: [
                Text(
                  '0:00',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  '-3:45',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    // Handle previous song action
                  },
                  child: Image.asset(
                    AppIcon.play_previous,
                    scale: 15,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isPlaying = !_isPlaying;
                    });
                  },
                  icon: Icon(
                    _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 70,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Handle next song action
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
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                child: Image.asset(
                  AppIcon.lyrics,
                  scale: 20,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              InkWell(
                child: Image.asset(
                  AppIcon.airplay,
                  scale: 20,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.timer_sharp,
                    color: Colors.white.withOpacity(0.7),
                    size: 35,
                  )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _isShowPlaylist = !_isShowPlaylist;
                    });
                  },
                  icon: Icon(
                    Icons.list_rounded,
                    color: Colors.white.withOpacity(0.7),
                    size: 35,
                  ))
            ],
          )
        ],
      ),
    );
  }

  List<Widget> _buildPlayerBackground() {
    return [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(currentSong.imgURL),
            fit: BoxFit.cover,
          ),
        ),
      ),
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
