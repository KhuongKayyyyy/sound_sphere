import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/album.dart';
import 'package:sound_sphere/data/models/artist.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/data/res/album_repository.dart';
import 'package:sound_sphere/data/res/track_repository.dart';
import 'package:sound_sphere/presentation/blocs/aritst/artist_bloc.dart';
import 'package:sound_sphere/presentation/views/artist_detail/components/artist_music.dart';
import 'package:sound_sphere/presentation/views/artist_detail/components/artist_new_album.dart';
import 'package:sound_sphere/presentation/views/artist_detail/components/artist_top_song.dart';
import 'package:sound_sphere/presentation/views/artist_detail/components/similar_artist_section.dart';

class ArtistDetailPage extends StatefulWidget {
  final Artist artist;
  const ArtistDetailPage({super.key, required this.artist});

  @override
  State<ArtistDetailPage> createState() => _ArtistDetailPageState();
}

class _ArtistDetailPageState extends State<ArtistDetailPage> {
  Artist artist = Artist.defaultArtist();
  Track newSong = FakeData.obitoSongs[4];

  ScrollController? _scrollController;
  bool showAppBar = false;

  Color appBarIconColor = Colors.white;
  late ArtistBloc artistBloc;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController!.addListener(_onScroll);

    artistBloc = ArtistBloc();
    artistBloc.add(FetchArtistDetailByIdEvent(widget.artist.id!));
  }

  @override
  void dispose() {
    _scrollController!.removeListener(_onScroll);
    _scrollController!.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController!.hasClients) {
      double offset = _scrollController!.offset;
      if (offset > 240 && !showAppBar) {
        setState(() {
          showAppBar = true;
        });
      } else if (offset <= 240 && showAppBar) {
        setState(() {
          showAppBar = false;
        });
      }

      appBarIconColor = offset > 200 ? AppColor.primaryColor : Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtistBloc, ArtistState>(
      bloc: artistBloc,
      builder: (context, artistState) {
        if (artistState is ArtistDetailByIdLoaded) {
          artist = artistState.artist;
          List<Track> trackOfArtist = artistState.trackOfArtist;
          List<Track> topTrackOfArtist = artistState.topTracksOfArtist;
          List<Album> albumOfArtist = artistState.albumOfArtist;
          List<Artist> relatedArtists = artistState.relatedArtists;
          Album latestAlbum = artistState.latestAlbum;

          return Scaffold(
            body: Stack(
              children: [
                CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    _buildAppBar(context),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          ArtistNewAlbum(
                            album: latestAlbum,
                          ),
                          ArtistTopSong(
                            topSongs: topTrackOfArtist.length > 8
                                ? topTrackOfArtist.take(8).toList()
                                : topTrackOfArtist,
                          ),
                          const SizedBox(height: 10),
                          if (albumOfArtist.isNotEmpty)
                            ArtistMusic(
                                sectionName: "Albums",
                                albumList: albumOfArtist),
                          ArtistMusic(
                              sectionName: "Single & EPs",
                              songList: trackOfArtist),
                          const SizedBox(height: 10),
                          ArtistMusic(
                              sectionName: "Artist Playlists",
                              albumList: FakeData.albums.take(8).toList()),
                          SimilarArtistSection(
                            similarArtists: relatedArtists,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                if (showAppBar)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: AppBar(
                      centerTitle: true,
                      title: Text(
                        artist.name!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      actions: [
                        // IconButton(
                        //   icon: const Icon(Icons.search),
                        //   onPressed: () {},
                        // ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(3),
                              child: Icon(Icons.star_outline_rounded)),
                        ),
                        const SizedBox(width: 15),
                        InkWell(
                          onTap: () {
                            TrackRepository.getTopTrackOfArtist(artist.id!);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(3),
                              child: Icon(Icons.more_horiz)),
                        ),
                        const SizedBox(width: 10),
                      ],
                      backgroundColor: Colors.white.withOpacity(0.9),
                      elevation: 0,
                      iconTheme: IconThemeData(color: appBarIconColor),
                    ),
                  ),
              ],
            ),
          );
        } else if (artistState is ArtistDetailByIdError) {
          return Scaffold(
            body: Center(
              child: Text(artistState.message),
            ),
          );
        } else {
          return Scaffold(
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  SliverAppBar _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true, // Keeps the AppBar visible when scrolling
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return FlexibleSpaceBar(
            centerTitle: true,
            background: Stack(
              fit: StackFit.expand,
              children: [
                // Background image
                Image.network(
                  artist.avatarURL!,
                  fit: BoxFit.cover,
                ),
                // Gradient overlay to darken the background
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                // Artist name and play button
                Positioned(
                  bottom: 20, // Position from bottom
                  left: 20, // Position from left
                  right: 20, // Position from right
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          artist.name!,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10),
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
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
