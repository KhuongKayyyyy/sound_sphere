import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/genres.dart';
import 'package:sound_sphere/presentation/views/main/library/components/library_genre_item.dart';

// ignore: must_be_immutable
class LibraryGenreList extends StatelessWidget {
  List<Genres> genres;
  LibraryGenreList({
    super.key,
    required this.genres,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                genres.first.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SizedBox(height: 10),
            ListView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: genres.length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(10),
                      child: LibraryGenreItem(genre: genres[index]),
                    )),
          ],
        )
      ],
    );
  }
}
