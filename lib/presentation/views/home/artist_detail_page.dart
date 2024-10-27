import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/album.dart';
import 'package:sound_sphere/data/models/artist.dart';
import 'package:sound_sphere/data/models/song.dart';
import 'package:sound_sphere/presentation/views/home/components/artist_rounded_avatar.dart';
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
                _buildArtistNewSong(),
                // top songs
                _buildAritstTopSongs(),
                const SizedBox(
                  height: 10,
                ),
                // albums
                _buildAritstMusic("Albums",
                    albumList: FakeData.albums.take(8).toList()),
                // artist song and eps
                _buildAritstMusic("Single & EPs",
                    songList: FakeData.songs.take(8).toList()),
                // artist playlist
                _buildAritstMusic("Artist Playlists",
                    albumList: FakeData.albums.take(8).toList()),
                // similar artist
                _buildSimilarArtist()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildArtistNewSong() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                newSong.imgURL,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "22 OCT 2022",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.grey,
                    fontSize: 15),
              ),
              Text(
                "${newSong.title} - Single",
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              const Text(
                "1 song",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: AppColor.primaryColor,
                        size: 25,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Add",
                        style: TextStyle(
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAritstTopSongs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: InkWell(
            onTap: () {},
            child: const Row(
              children: [
                Text(
                  "Top Songs ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 350,
          width: double.infinity,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              mainAxisExtent: 330,
            ),
            itemCount: 8,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          FakeData.songs[index].imgURL,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                        width: 10), // Add spacing between image and text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            FakeData.songs[index].title,
                            overflow: TextOverflow
                                .ellipsis, // Prevent overflow in text
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "${FakeData.albums[index].title}·${FakeData.albums[index].releaseDate}",
                            overflow: TextOverflow
                                .ellipsis, // Prevent overflow in text
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          Divider(
                            color: Colors.grey[200],
                            height: 30,
                          )
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.more_horiz))
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget _buildAritstMusic(String sectionName,
      {List<Song>? songList, List<Album>? albumList}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: InkWell(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  sectionName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w900),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey,
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        if (songList != null)
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: songList.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SongItem(song: songList[index]));
              },
            ),
          ),
        if (albumList != null)
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: albumList.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: AlbumItem(album: albumList[index]));
              },
            ),
          ),
      ],
    );
  }

  Widget _buildSimilarArtist() {
    return Container(
      color: Colors.grey[200],
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: () {},
              child: const Row(
                children: [
                  Text(
                    "Similar Artists",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ArtistRoundedAvatar(
                    artist: FakeData.artists[index],
                    isLike: false,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
