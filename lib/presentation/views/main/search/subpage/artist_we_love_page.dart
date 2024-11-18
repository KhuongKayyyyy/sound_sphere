import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/views/main/search/components/artist_we_love_item.dart';

class ArtistWeLovePage extends StatelessWidget {
  const ArtistWeLovePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => context.pop(),
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColor.primaryColor,
            )),
        title: const Text(
          "Artists We Love",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView.builder(
        itemCount: FakeData.artists.length,
        itemBuilder: (context, index) => ArtistWeLoveItem(
          artist: FakeData.artists.elementAt(index),
        ),
      ),
    );
  }
}
