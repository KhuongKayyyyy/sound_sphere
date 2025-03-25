import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/album.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/data/models/track_in_library.dart';
import 'package:sound_sphere/presentation/blocs/album/album_bloc.dart';
import 'package:sound_sphere/presentation/blocs/library/library_bloc.dart';
import 'package:sound_sphere/presentation/views/album_detail/components/album_app_bar.dart';
import 'package:sound_sphere/presentation/views/album_detail/components/album_brief_info.dart';
import 'package:sound_sphere/presentation/views/album_detail/components/album_detail_popup.dart';
import 'package:sound_sphere/presentation/views/album_detail/components/album_song_list.dart';
import 'package:sound_sphere/presentation/views/album_detail/components/artist_music_section.dart';

class AlbumDetailPage extends StatefulWidget {
  final Album album;

  const AlbumDetailPage({super.key, required this.album});

  @override
  State<AlbumDetailPage> createState() => _AlbumDetailPageState();
}

class _AlbumDetailPageState extends State<AlbumDetailPage> {
  ScrollController? _scrollController;
  bool showAppBarTitle = false;
  Color appBarIconColor = Colors.white;

  late AlbumBloc albumBloc;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController!.addListener(_onScroll);

    albumBloc = AlbumBloc();
    albumBloc.add(FetchAlbumDetailEvent(widget.album.id!));
    context.read<LibraryBloc>().add(GetTrackLibraryRequest());
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
            album: widget.album,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AlbumBloc, AlbumState>(
        bloc: albumBloc,
        builder: (context, albumState) {
          if (albumState is AlbumDetailLoaded) {
            return _buildAlbumDetailPage(
                album: albumState.album,
                popularTracks: albumState.topTrackOfArtist,
                featuredTracks: albumState.featuredTracks,
                favoriteTracks: albumState.favoriteTracks);
          } else {
            return Skeletonizer(
                child: _buildAlbumDetailPage(
                    album: FakeData.gnx,
                    popularTracks: FakeData.gnxTracks,
                    featuredTracks: FakeData.gnxTracks,
                    favoriteTracks: []));
          }
        },
      ),
    );
  }

  CustomScrollView _buildAlbumDetailPage(
      {required Album album,
      required List<Track> popularTracks,
      required List<Track> featuredTracks,
      required List<TrackInLibrary> favoriteTracks}) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        AlbumDetailAppBar(
          album: album,
          showAppBarTitle: showAppBarTitle,
          appBarIconColor: appBarIconColor,
          showCupertinoBottomSheet: _showCupertinoBottomSheet,
        ),
        AlbumSongList(tracks: album.tracks, favoriteTracks: favoriteTracks),
        AlbumBriefInfo(album: album),
        SliverToBoxAdapter(
          child: Container(
            color: Colors.grey[100],
            child: Column(
              children: [
                const SizedBox(height: 20),
                if (popularTracks.isNotEmpty)
                  ArtistMusicSection(
                      title: "Popular by ${album.aritst.name}",
                      songs: popularTracks),
                if (featuredTracks.isNotEmpty)
                  ArtistMusicSection(
                      title: "Featured on", songs: featuredTracks),
                const SizedBox(height: 150),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
