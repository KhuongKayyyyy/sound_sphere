import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/api_config.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/album.dart';
import 'package:sound_sphere/data/models/search_category.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/presentation/blocs/album/album_bloc.dart';
import 'package:sound_sphere/presentation/blocs/aritst/artist_bloc.dart';
import 'package:sound_sphere/presentation/views/main/browse/components/top_songs_section.dart';
import 'package:sound_sphere/presentation/views/main/home/components/media_section.dart';
import 'package:sound_sphere/presentation/views/main/search/components/artist_we_love_section.dart';
import 'package:sound_sphere/presentation/views/main/search/components/new_release_item.dart';

class SearchCategoryDetail extends StatefulWidget {
  final SearchCategory category;
  const SearchCategoryDetail({super.key, required this.category});

  @override
  State<SearchCategoryDetail> createState() => _SearchCategoryDetailState();
}

class _SearchCategoryDetailState extends State<SearchCategoryDetail> {
  late final ArtistBloc artistBloc;
  late final AlbumBloc albumBloc;
  @override
  void initState() {
    artistBloc = ArtistBloc();
    artistBloc.add(
        FetchArtistsEvent(1, ApiConfig.DEFAULT_LIMIT, ArtistApi.nameAndAvatar));

    albumBloc = AlbumBloc();
    albumBloc.add(FetchAlbumsPreviewEvent(1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        leading: InkWell(
          onTap: () => context.pop(),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColor.primaryColor,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
            child: Icon(
              Icons.more_horiz_rounded,
              color: AppColor.primaryColor,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                widget.category.name,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 270,
              child: ListView.builder(
                itemCount: FakeData.albums.take(5).length +
                    FakeData.obitoSongs.take(5).length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  // Combine both lists and check the type
                  final item = index < FakeData.albums.take(5).length
                      ? FakeData.albums.take(5).elementAt(index)
                      : FakeData
                          .obitoSongs[index - FakeData.albums.take(5).length];

                  // Check if the item is an Album or a Song
                  if (item is Album) {
                    return Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: NewReleaseItem(album: item));
                  } else if (item is Track) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: NewReleaseItem(song: item),
                    );
                  }

                  return const SizedBox
                      .shrink(); // Fallback in case of an unexpected type
                },
              ),
            ),
            MediaSection(
              mediaSectionTitle: "Playlist",
              songList: FakeData.obitoSongs.take(10).toList(),
              isExpandable: true,
              onPressed: () => context.pushNamed(
                Routes.extendListView,
                extra: {
                  'songs': FakeData.obitoSongs.take(10).toList(),
                  'title': "Playlist",
                },
              ),
            ),
            MediaSection(
              mediaSectionTitle: "New Release",
              songList: FakeData.obitoSongs.take(10).toList(),
              isExpandable: true,
              onPressed: () => context.pushNamed(
                Routes.extendGridView,
                extra: {
                  'songs': FakeData.wrxdieSong.take(10).toList(),
                  'title': "New Release",
                },
              ),
            ),
            MediaSection(
              mediaSectionTitle: "Vietnamese Music In Spatial Audio",
              songList: FakeData.obitoSongs.take(10).toList(),
              isExpandable: true,
              onPressed: () => context.pushNamed(
                Routes.extendListView,
                extra: {
                  'songs': FakeData.obitoSongs.take(10).toList(),
                  'title': "Vietnamese Music In Spatial Audio",
                },
              ),
            ),
            MediaSection(
              mediaSectionTitle: "International Collaboration",
              songList: FakeData.obitoSongs.take(10).toList(),
              isExpandable: true,
              onPressed: () => context.pushNamed(
                Routes.extendGridView,
                extra: {
                  'songs': FakeData.wrxdieSong.take(10).toList(),
                  'title': "International Collaboration",
                },
              ),
            ),
            TopSongsSection(
              songList: FakeData.obitoSongs.take(9).toList(),
              isBlackTitle: true,
            ),
            _buildEssentialAlbumSection(),
            // TextButton(
            //     onPressed: () async {
            //       // AlbumRepository.fetchAlbumWithPreviewInformation(
            //       //     "title image_url artist");
            //       ArtistRepository.fetchArtists(1);
            //     },
            //     child: Text("test ")),
            _buildArtistWeLoveSection(),
            const SizedBox(
              height: 150,
            )
          ],
        ),
      ),
    );
  }

  BlocBuilder<AlbumBloc, AlbumState> _buildEssentialAlbumSection() {
    return BlocBuilder<AlbumBloc, AlbumState>(
      bloc: albumBloc,
      builder: (context, albumState) {
        if (albumState is AlbumPreviewLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (albumState is AlbumPreviewLoaded) {
          return MediaSection(
            mediaSectionTitle: "Essential Albums",
            albumList: albumState.albums,
            isExpandable: true,
            onPressed: () => context.pushNamed(
              Routes.extendGridView,
              extra: {
                'songs': albumState.albums,
                'title': "Essental Albums",
              },
            ),
          );
        } else if (albumState is AlbumPreviewError) {
          return Center(
            child: Text(albumState.message),
          );
        }
        return const Text("did not add event");
      },
    );
  }

  BlocBuilder<ArtistBloc, ArtistState> _buildArtistWeLoveSection() {
    return BlocBuilder<ArtistBloc, ArtistState>(
      bloc: artistBloc,
      builder: (context, artistState) {
        if (artistState is ArtistLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (artistState is ArtistLoaded) {
          return ArtistWeLoveSection(artists: artistState.artists);
        } else if (artistState is ArtistError) {
          return Center(
            child: Text(artistState.message),
          );
        }
        return const Text("did not add event");
      },
    );
  }
}
