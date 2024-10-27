import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/album.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/data/models/song.dart';
import 'package:sound_sphere/presentation/views/home/album_detail_popup.dart';
import 'package:sound_sphere/presentation/widgets/album/album_item.dart';
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
          // appBar
          _buildAlbumDetailAppBar(),
          // song list
          _buildAlbumSongList(),
          _buildAlbumBriefInfo(),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.grey[100],
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  _buildAritstMusic("More by ${tempAlbum.artistName}",
                      albumList: FakeData.albums),
                  _buildAritstMusic("Featured on",
                      songList: FakeData.songs.take(10).toList()),
                  const SizedBox(
                    height: 150,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlbumDetailAppBar() {
    return SliverAppBar(
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
                _showCupertinoBottomSheet(context); // Call the new function
              },
            ),
          ),
        ],
      ),
      actions: [
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Colors.black.withOpacity(0.1)),
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
              shape: BoxShape.circle, color: Colors.black.withOpacity(0.1)),
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
                        Text("${tempAlbum.genre.name}·${tempAlbum.releaseDate}",
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
    );
  }

  Widget _buildAlbumSongList() {
    return SliverPadding(
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
                  thickness: 1,
                ),
              ],
            );
          },
          childCount: tempAlbum.songs.length,
        ),
      ),
    );
  }

  Widget _buildAlbumBriefInfo() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tempAlbum.releaseDate,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[400]),
            ),
            Text(
              "${tempAlbum.songs.length} songs, ${tempAlbum.getAlbumDuration()}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[400]),
            ),
            Text(
              "© ${tempAlbum.artistName} ${tempAlbum.releaseDate}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[400]),
            ),
          ],
        ),
      ),
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

  // Function to show Cupertino bottom sheet
  void _showCupertinoBottomSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) {
        return CupertinoPopupSurface(
          child: AlbumDetailPopup(
            album: tempAlbum,
          ),
        );
      },
    );
  }
}
