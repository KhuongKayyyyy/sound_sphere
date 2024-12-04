import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/core/utils/helpers.dart';
import 'package:sound_sphere/data/models/album.dart';

// ignore: must_be_immutable
class ArtistNewAlbum extends StatelessWidget {
  Album album;
  ArtistNewAlbum({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // if (album.type == 'album') {
          //   context.pushNamed(Routes.albumDetail, extra: album.id);
          // } else if (album.type == 'single') {
          //   context.pushNamed(Routes.songDetail,
          //       extra: "6747e542c99cd7beea6ecbff");
          // }
          context.pushNamed(Routes.albumDetail, extra: album.id);
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    album.imgURL,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Helpers.formatDate(album.releaseDate),
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.grey,
                        fontSize: 15),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      maxLines: 2,
                      "${album.title} ${album.type == 'album' ? '- Album' : ''}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "1 song",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: AppColor.primaryColor,
                            size: 25,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Add",
                            style: TextStyle(
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
