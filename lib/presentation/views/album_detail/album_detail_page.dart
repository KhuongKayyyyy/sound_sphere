import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/album.dart';
import 'package:sound_sphere/presentation/views/album_detail/components/album_app_bar.dart';
import 'package:sound_sphere/presentation/views/album_detail/components/album_brief_info.dart';
import 'package:sound_sphere/presentation/views/album_detail/components/album_detail_popup.dart';
import 'package:sound_sphere/presentation/views/album_detail/components/album_song_list.dart';
import 'package:sound_sphere/presentation/views/album_detail/components/artist_music_section.dart';

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
    setState(() {
      showAppBarTitle = _scrollController!.offset > 250;
      appBarIconColor = _scrollController!.offset > 250
          ? AppColor.primaryColor
          : Colors.white;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          AlbumDetailAppBar(
            tempAlbum: tempAlbum,
            showAppBarTitle: showAppBarTitle,
            appBarIconColor: appBarIconColor,
            showCupertinoBottomSheet: _showCupertinoBottomSheet,
          ),
          AlbumSongList(songs: tempAlbum.songs),
          AlbumBriefInfo(tempAlbum: tempAlbum),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.grey[100],
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  ArtistMusicSection(
                      title: "More by ${tempAlbum.artistName}",
                      albums: FakeData.albums),
                  ArtistMusicSection(
                      title: "Featured on",
                      songs: FakeData.songs.take(10).toList()),
                  const SizedBox(height: 150),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
