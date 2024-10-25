import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/album.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/data/models/song.dart';
import 'package:sound_sphere/presentation/widgets/song/song_item.dart';

class AlbumDetailPage extends StatefulWidget {
  final String albumId;

  AlbumDetailPage({super.key, required this.albumId});
  @override
  State<AlbumDetailPage> createState() => _AlbumDetailPageState();
}

class _AlbumDetailPageState extends State<AlbumDetailPage> {
  Album tempAlbum = FakeData.albums.first;
  ScrollController? _scrollController;
  bool showAppBarTitle = false;
  Color appBarIconColor = Colors.white;

  @override
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
    if (_scrollController!.offset > 250 && !showAppBarTitle) {
      setState(() {
        showAppBarTitle = true;
      });
    } else if (_scrollController!.offset <= 250 && showAppBarTitle) {
      setState(() {
        showAppBarTitle = false;
      });
    }
    // Change icon color based on scroll position
    if (_scrollController!.offset > 250) {
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
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // app bar
          SliverAppBar(
            pinned: true,
            expandedHeight: 300,
            leadingWidth: 120,
            leading: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.1),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: appBarIconColor,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.1),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.info),
                    color: appBarIconColor,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            actions: [
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.1)),
                height: kToolbarHeight,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: Icon(Icons.add, color: appBarIconColor),
                  alignment: Alignment.center,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.1)),
                height: kToolbarHeight,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: Icon(Icons.more_horiz_rounded, color: appBarIconColor),
                  alignment: Alignment.center,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: showAppBarTitle
                  ? Text(
                      tempAlbum.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  : null,
              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(tempAlbum.imgURL),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      tempAlbum.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        context.pushNamed(
                          Routes.artistDetail,
                          extra: "artistId",
                        );
                      },
                      child: Text(
                        tempAlbum.artistName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "${tempAlbum.genre.name}·${tempAlbum.releaseDate}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset(
                                      AppIcon.quality,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset(
                                      AppIcon.audio,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset(
                                      AppIcon.dolby,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Container(
                                  height: 48,
                                  width: 48,
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.primaryColor,
                                  ),
                                  child: InkWell(
                                    child: Image.asset(
                                      AppIcon.shuffle,
                                      color: Colors.white,
                                    ),
                                  )),
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
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // song list
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "${index + 1}",
                            style: TextStyle(
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            tempAlbum.songs[index].title,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_horiz_rounded),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.black.withOpacity(0.2),
                        thickness:
                            1, // Optional: You can specify the thickness of the divider
                      ),
                    ],
                  );
                },
                childCount: tempAlbum.songs.length,
              ),
            ),
          ),
          // information section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tempAlbum.releaseDate,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    style: const TextStyle(fontWeight: FontWeight.w500),
                    "${tempAlbum.songs.length} songs, ${tempAlbum.getAlbumDuration()}",
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 15,
                        width: 15,
                        child: Image.asset(AppIcon.producer),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        tempAlbum.artistName,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ), // Display the album artist name
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.1)),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align children to the start
                children: [
                  // First song list container
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: InkWell(
                            child: Row(
                              children: [
                                Text(
                                  "More from ${tempAlbum.artistName}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          // Set a fixed height for the horizontal list
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 8,
                            itemBuilder: (context, index) {
                              List<Song> songs =
                                  FakeData.songs.take(8).toList();
                              return Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: SongItem(song: songs.elementAt(index)),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Second song list container
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: InkWell(
                            child: Row(
                              children: [
                                Text(
                                  "Featured on",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          // Set a fixed height for the horizontal list
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 8,
                            itemBuilder: (context, index) {
                              List<Song> songs =
                                  FakeData.songs.take(8).toList();
                              return Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: SongItem(song: songs.elementAt(index)),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 150),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
