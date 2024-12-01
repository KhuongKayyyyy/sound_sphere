import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/controller/player_controller.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/album.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/presentation/widgets/album/album_item.dart';
import 'package:sound_sphere/presentation/widgets/media/media_item.dart';

// ignore: must_be_immutable
class SingleEPsDetailPage extends StatefulWidget {
  String songId;
  SingleEPsDetailPage({super.key, required this.songId});

  @override
  State<SingleEPsDetailPage> createState() => _SingleEPsDetailPageState();
}

class _SingleEPsDetailPageState extends State<SingleEPsDetailPage> {
  bool showAppBarTitle = false;
  ScrollController _scrollController = ScrollController();
  Track tempSong = FakeData.obitoSongs.first;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 250 && !showAppBarTitle) {
      setState(() {
        showAppBarTitle = true;
      });
    } else if (_scrollController.offset <= 250 && showAppBarTitle) {
      setState(() {
        showAppBarTitle = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _buildSingleDetailAppBar(),
          _buildSingleDetailSection(),
          _buildPlaySection(),
          _buildSingleSongList(),
          _buildSingleBriefInfo(),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.grey[100],
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  _buildAritstMusic("More by ${tempSong.artist}",
                      albumList: FakeData.albums),
                  _buildAritstMusic("Featured on",
                      songList: FakeData.obitoSongs.take(10).toList()),
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

  Widget _buildSingleDetailAppBar() {
    return SliverAppBar(
      toolbarHeight: 50,
      pinned: true,
      title: showAppBarTitle
          ? Text(
              FakeData.obitoSongs.first.title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
            )
          : null,
      centerTitle: true,
      actions: [
        _buildAppBarIcon(Icons.favorite_outline_rounded, () {}),
        const SizedBox(
          width: 10,
        ),
        _buildAppBarIcon(Icons.more_horiz_rounded, () {}),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Widget _buildAppBarIcon(IconData icon, Function() onTap) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(5),
            child: Icon(
              icon,
              size: 20,
            )),
      ),
    );
  }

  Widget _buildSingleDetailSection() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ]),
            height: 200,
            width: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                tempSong.imgURL,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "${tempSong.title}- Single",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            tempSong.artist,
            style: TextStyle(
                fontSize: 20,
                color: AppColor.primaryColor,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "Hip hop · 2021 · Lossless",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaySection() {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          _buildPlayButton(AppIcon.play, "Play", () {
            PlayerController().setPlayerAudio([tempSong]);
            PlayerController().isPlayingAlbum = false;
          }),
          _buildPlayButton(AppIcon.shuffle, "Shuffle", () {}),
        ],
      ),
    );
  }

  Widget _buildPlayButton(String icon, String text, Function() onTap) {
    return Expanded(
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                scale: 30,
                color: AppColor.primaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSingleSongList() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return _buildSongItem(index);
          },
          childCount: 1,
        ),
      ),
    );
  }

  Widget _buildSongItem(int index) {
    return Column(children: [
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
            tempSong.title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
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
      )
    ]);
  }

  Widget _buildSingleBriefInfo() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "2019",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[400]),
            ),
            Text(
              "1 song, 4 minutes",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[400]),
            ),
            Text(
              "© ${tempSong.artist} 2019",
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
      {List<Track>? songList, List<Album>? albumList}) {
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
                    child: MediaItem(song: songList[index]));
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
}
