import 'package:flutter/material.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/views/artist_detail/components/artist_rounded_avatar.dart';
import 'package:sound_sphere/presentation/widgets/artist/artist_item.dart';

class ArtistWeLoveSection extends StatelessWidget {
  const ArtistWeLoveSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Text("Artists We Love",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey,
              )
            ],
          ),
        ),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: ArtistRoundedAvatar(
                artist: FakeData.artists.elementAt(index),
                isLike: false,
                onTap: () {},
              ),
            ),
          ),
        )
      ],
    );
  }
}
