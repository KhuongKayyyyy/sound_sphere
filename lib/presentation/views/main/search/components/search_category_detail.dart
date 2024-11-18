import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/album.dart';
import 'package:sound_sphere/data/models/search_category.dart';
import 'package:sound_sphere/data/models/song.dart';
import 'package:sound_sphere/presentation/views/main/browse/components/top_songs_section.dart';
import 'package:sound_sphere/presentation/views/main/home/components/song_section.dart';
import 'package:sound_sphere/presentation/views/main/search/components/artist_we_love_section.dart';
import 'package:sound_sphere/presentation/views/main/search/components/new_release_item.dart';

class SearchCategoryDetail extends StatefulWidget {
  final SearchCategory category;
  const SearchCategoryDetail({super.key, required this.category});

  @override
  State<SearchCategoryDetail> createState() => _SearchCategoryDetailState();
}

class _SearchCategoryDetailState extends State<SearchCategoryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  } else if (item is Song) {
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
            SongSection(
              songSectionTitle: "Playlist",
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
            SongSection(
              songSectionTitle: "New Release",
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
            SongSection(
              songSectionTitle: "Vietnamese Music In Spatial Audio",
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
            SongSection(
              songSectionTitle: "International Collaboration",
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
            SongSection(
              songSectionTitle: "Essential Albums",
              songList: FakeData.obitoSongs.take(10).toList(),
              isExpandable: true,
              onPressed: () => context.pushNamed(
                Routes.extendGridView,
                extra: {
                  'songs': FakeData.wrxdieSong.take(10).toList(),
                  'title': "Essental Albums",
                },
              ),
            ),
            ArtistWeLoveSection(),
            const SizedBox(
              height: 150,
            )
          ],
        ),
      ),
    );
  }
}
