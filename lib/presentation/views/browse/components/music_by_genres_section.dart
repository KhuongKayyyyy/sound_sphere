import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/genres.dart';
import 'package:sound_sphere/presentation/views/browse/components/genres_item.dart';

class MusicByGenresSection extends StatelessWidget {
  final String sectionTitle;
  final List<Genres> genresList;

  MusicByGenresSection(
      {super.key, required this.genresList, required this.sectionTitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Theme.of(context).primaryColor, Colors.purple],
                tileMode: TileMode.mirror,
              ).createShader(bounds),
              child: Text(
                sectionTitle,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.symmetric(vertical: 10),
              scrollDirection:
                  Axis.horizontal, // Change to horizontal scrolling
              crossAxisCount: 2,
              childAspectRatio: 0.45,
              crossAxisSpacing: 10,
              children: List.generate(genresList.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: GenresItem(
                    genres: genresList[index],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
