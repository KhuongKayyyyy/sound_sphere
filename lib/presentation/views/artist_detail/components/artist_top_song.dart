import 'package:flutter/material.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';

class ArtistTopSong extends StatelessWidget {
  const ArtistTopSong({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: InkWell(
            onTap: () {},
            child: const Row(
              children: [
                Text(
                  "Top Songs ",
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
        SizedBox(
          height: 350,
          width: double.infinity,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              mainAxisExtent: 330,
            ),
            itemCount: 8,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          FakeData.songs[index].imgURL,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                        width: 10), // Add spacing between image and text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            FakeData.songs[index].title,
                            overflow: TextOverflow
                                .ellipsis, // Prevent overflow in text
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "${FakeData.albums[index].title}·${FakeData.albums[index].releaseDate}",
                            overflow: TextOverflow
                                .ellipsis, // Prevent overflow in text
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          Divider(
                            color: Colors.grey[200],
                            height: 30,
                          )
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.more_horiz))
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
