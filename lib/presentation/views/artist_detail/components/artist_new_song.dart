import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/data/models/song.dart';

class ArtistNewSong extends StatelessWidget {
  Song newSong;
  ArtistNewSong({super.key, required this.newSong});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                newSong.imgURL,
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
              const Text(
                "22 OCT 2022",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.grey,
                    fontSize: 15),
              ),
              Text(
                "${newSong.title} - Single",
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              const Text(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
    );
  }
}
