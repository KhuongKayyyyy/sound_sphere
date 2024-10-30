import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/album.dart';
import 'package:sound_sphere/data/models/artist.dart';
import 'package:sound_sphere/data/models/song.dart';
import 'package:sound_sphere/presentation/views/artist_detail/components/artist_music.dart';
import 'package:sound_sphere/presentation/views/artist_detail/components/artist_new_song.dart';
import 'package:sound_sphere/presentation/views/artist_detail/components/artist_rounded_avatar.dart';
import 'package:sound_sphere/presentation/views/artist_detail/components/artist_top_song.dart';
import 'package:sound_sphere/presentation/views/artist_detail/components/similar_artist_section.dart';
import 'package:sound_sphere/presentation/widgets/album/album_item.dart';
import 'package:sound_sphere/presentation/widgets/song/song_item.dart';

// ignore: must_be_immutable
class ArtistDetailPage extends StatefulWidget {
  String? artistId;
  ArtistDetailPage({super.key, required this.artistId});

  @override
  State<ArtistDetailPage> createState() => _ArtistDetailPageState();
}

class _ArtistDetailPageState extends State<ArtistDetailPage> {
  // fake data for artist detail
  Artist tempArtist = FakeData.artists.first;
  Song newSong = FakeData.songs[4];

  ScrollController? _scrollController;
  bool showAppBar = false;
  // bool showBackButton = true;
  Color appBarIconColor = Colors.white;

  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController!.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController!.removeListener(_onScroll);
    _scrollController!.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController!.offset > 200 && !showAppBar) {
      setState(() {
        showAppBar = true;
      });
    } else if (_scrollController!.offset <= 200 && showAppBar) {
      setState(() {
        showAppBar = false;
      });
    }

    // if (_scrollController!.offset > 150 && !showAppBar) {
    //   setState(() {
    //     showBackButton = false;
    //   });
    // } else if (_scrollController!.offset <= 150 && showAppBar) {
    //   setState(() {
    //     showBackButton = true;
    //   });
    // }
    // Change icon color based on scroll position
    if (_scrollController!.offset > 200) {
      setState(() {
        appBarIconColor = AppColor.primaryColor; // Change to primary color
      });
    } else {
      setState(() {
        appBarIconColor = Colors.white; // Change back to white
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: Text(
                tempArtist.name,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              backgroundColor: Colors.white.withOpacity(0.5),
              iconTheme: IconThemeData(color: appBarIconColor),
            )
          : null,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
              expandedHeight: 300,
              flexibleSpace: !showAppBar
                  ? Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(tempArtist.avatarURL),
                              fit: BoxFit.cover)),
                      child: Column(
                        children: [
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Text(
                                  tempArtist.name,
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.primaryColor,
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.play_arrow),
                                    color: Colors.white,
                                    onPressed: () {
                                      GoRouter.of(context).go('/player');
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    )
                  : null),
          SliverToBoxAdapter(
            child: Column(
              children: [
                // new song
                ArtistNewSong(newSong: newSong),
                // top songs
                const ArtistTopSong(),
                const SizedBox(
                  height: 10,
                ),
                // artist albums
                ArtistMusic(
                    sectionName: "Albums",
                    albumList: FakeData.albums.take(8).toList()),
                // artist song and eps
                ArtistMusic(
                    sectionName: "Single & EPs",
                    songList: FakeData.songs.take(8).toList()),
                // artist playlist
                ArtistMusic(
                    sectionName: "Artist Playlists",
                    albumList: FakeData.albums.take(8).toList()),

                // similar artist
                const SimilarArtistSection(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
