import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/views/home/components/artist_rounded_avatar.dart';
import 'package:sound_sphere/presentation/widgets/search_bar/custom_search_bar.dart';

class AddArtistPage extends StatefulWidget {
  const AddArtistPage({super.key});

  @override
  State<AddArtistPage> createState() => _AddArtistPageState();
}

class _AddArtistPageState extends State<AddArtistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Artist"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none_rounded,
              color: AppColor.primaryColor,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child:
                CustomSearchBar(textHint: "Favorite artists", isWhite: false),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.5,
                ),
                itemBuilder: (context, index) {
                  if (index % 3 == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: ArtistRoundedAvatar(
                          artist: FakeData.artists.first,
                          isLike: true,
                          onTap: () {}),
                    );
                  } else if (index % 3 != 0)
                    // ignore: curly_braces_in_flow_control_structures
                    return Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: ArtistRoundedAvatar(
                          artist: FakeData.artists.first,
                          isLike: false,
                          onTap: () {}),
                    );
                  return null;
                },
                itemCount: 14, // Add an item count for demonstration
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          margin:
              const EdgeInsets.only(left: 10, right: 10, bottom: 40, top: 10),
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Center(
            child: Text(
              "Confirm",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
