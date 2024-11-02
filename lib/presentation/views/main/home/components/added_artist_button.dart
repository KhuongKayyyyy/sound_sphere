import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/data/models/artist.dart';
import 'package:sound_sphere/presentation/widgets/artist/artist_item.dart';
import 'package:go_router/go_router.dart';

class AddedArtist extends StatelessWidget {
  final List<Artist> myArtistList;
  final List<Artist> displayArtist;

  AddedArtist({super.key, required this.myArtistList})
      : displayArtist = myArtistList.take(3).toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColor.secondaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Text(
            "Recently Added",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ArtistItem(
                          artist: displayArtist.elementAt(0),
                          size: 50,
                        ),
                        const SizedBox(width: 20),
                        ArtistItem(
                            artist: displayArtist.elementAt(1), size: 50),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 60,
                    child: ArtistItem(
                        artist: displayArtist.elementAt(2), size: 60),
                  )
                ],
              ),
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () => context.pushNamed(Routes.addArtist),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Center(
                child: Text("Add more",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
