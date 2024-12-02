import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/data/models/artist.dart';
import 'package:sound_sphere/presentation/views/artist_detail/components/artist_rounded_avatar.dart';

class SimilarArtistSection extends StatelessWidget {
  final List<Artist> similarArtists;
  const SimilarArtistSection({super.key, required this.similarArtists});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: () {},
              child: const Row(
                children: [
                  Text(
                    "Similar Artists",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                  Icon(
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
          SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ArtistRoundedAvatar(
                    artist: similarArtists[index],
                    isLike: false,
                    onTap: () {
                      context.pushNamed(Routes.artistDetail, extra: "");
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
