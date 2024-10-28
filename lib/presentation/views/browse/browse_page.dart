import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/views/home/components/playlist_section.dart';
import 'package:sound_sphere/presentation/views/home/components/song_section.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  int _currentIndex = 0;
  bool showAppBarTitle = false;
  ScrollController _scrollController = ScrollController();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _buildAppBar(),
          // _buildBrowseHomePage(),
          _buildBrowseGenresPage(),
          SliverToBoxAdapter(
              child: Container(
            color: Colors.grey[200],
            height: 150,
          ))
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      toolbarHeight: 50,
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildAppBarButton(
            title: 'Home',
            isActive: _currentIndex == 0,
            onPressed: () {
              setState(() {
                _currentIndex = 0;
              });
            },
          ),
          _buildAppBarButton(
            title: 'Radio',
            isActive: _currentIndex == 1,
            onPressed: () {
              setState(() {
                _currentIndex = 1;
              });
            },
          ),
          _buildAppBarButton(
            title: 'Genres',
            isActive: _currentIndex == 2,
            onPressed: () {
              setState(() {
                _currentIndex = 2;
              });
            },
          ),
          _buildAppBarButton(
            title: 'Charts',
            isActive: _currentIndex == 3,
            onPressed: () {
              setState(() {
                _currentIndex = 3;
              });
            },
          ),
        ],
      ),
      floating: true,
      pinned: true,
    );
  }

  Widget _buildAppBarButton({
    required VoidCallback onPressed,
    required String title,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        width: 80,
        height: 30,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: isActive ? AppColor.primaryColor : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBrowseHomePage() {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 20),
              child: Text(
                "Browse",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
            ),
            _buildPlayListSection(
                imageList: FakeData.chrismastPlaylistImg, isBig: true),
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                "Happy new year!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
            ),
            _buildPlayListSection(
                imageList: FakeData.newYearPlaylistImg, isBig: false),
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 10, top: 10),
              child: Text(
                "Best of 2024",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
            ),
            _buildPlayListSection(
                imageList: FakeData.newYearPlaylistImg, isBig: false),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaylistItem({required String img, required bool isBig}) {
    return Column(
      children: [
        Container(
          height: isBig ? 150 : 180,
          width: isBig ? 330 : 180,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              img,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          isBig ? "Your New Year Starts Here!" : "Midnight Countdown",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          isBig
              ? "Wave goodbye to 2021 with these incredible tracks"
              : "SoundSphere Music Party",
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        )
      ],
    );
  }

  Widget _buildPlayListSection(
      {required List<String> imageList, required bool isBig}) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: index == imageList.length - 1
                ? const EdgeInsets.symmetric(horizontal: 20)
                : const EdgeInsets.only(left: 20),
            child: _buildPlaylistItem(img: imageList[index], isBig: isBig),
          );
        },
      ),
    );
  }

  Widget _buildBrowseGenresPage() {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 20),
              child: Text(
                "Genres",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
            ),
            _buildPlayListSection(
                imageList: FakeData().rockAlbumCover, isBig: true)
          ],
        ),
      ),
    );
  }
}
