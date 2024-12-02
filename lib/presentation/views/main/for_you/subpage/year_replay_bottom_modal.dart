import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/artist.dart';

class YearReplayBottomModal extends StatelessWidget {
  const YearReplayBottomModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 30),
                _replayAppBar(context),
                _replayHeader(context),
                const SizedBox(height: 10),
                _replayStandOut(),
              ],
            ),
          ),
          // replay features
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _replayFeature("781 Songs Played"),
                const SizedBox(width: 5),
                _replayFeature("11 New Artists"),
                const SizedBox(width: 5),
                _replayFeature("3 New Genres"),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Top 10 Artists",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 170,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: FakeData.artists.take(10).toList().length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: 10, left: index == 0 ? 20 : 0, right: 20),
                      child:
                          _replayTopAristItem(FakeData.artists[index], index),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _replayTopAristItem(Artist artist, int index) {
    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                artist.avatarURL!,
                height: 130,
                width: 130,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 10,
              bottom: 10,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ]),
                child: Center(
                  child: Text(
                    (index + 1).toString(),
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        Text(
          artist.name!,
          style: TextStyle(
            color: AppColor.primaryColor,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget _replayFeature(String featureName) {
    List<String> words = featureName.split(' ');
    String firstLine = words.sublist(0, 1).join(' ');
    String secondLine = words.sublist(1, 2).join(' ');
    String thirdLine = words.sublist(2).join(' ');

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ]),
        child: Center(
          child: Column(
            children: [
              Text(
                firstLine,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryColor,
                ),
              ),
              Text(
                secondLine,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: AppColor.primaryColor,
                ),
              ),
              Text(
                thirdLine,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: AppColor.primaryColor,
                ),
              ),
            ],
          ),
        ));
  }

  Widget _replayStandOut() {
    return Row(
      children: [
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 5,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              FakeData.albums.first.imgURL,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Top Genre",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Hip Hop",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: AppColor.primaryColor),
            ),
            Text(
              "316 hours listened",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 60),
            Text(
              "Top Artist",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Travis Scott",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColor.primaryColor),
            ),
            Text(
              "100 hours listened",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _replayAppBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.share,
              color: AppColor.primaryColor,
            )),
        const Spacer(),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.xmark,
              color: AppColor.primaryColor,
            )),
      ],
    );
  }

  Widget _replayHeader(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [AppColor.primaryColor, Colors.purple],
                  tileMode: TileMode.mirror,
                ).createShader(bounds),
                child: const Row(
                  children: [
                    Text(
                      "Replay 2024",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              Text(
                "YOUR YEAR IN REVIEW",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
        ),
        const Spacer(),
        _buildPlaybackButton(context, AppIcon.shuffle, null),
        const SizedBox(width: 10),
        _buildPlaybackButton(context, null, Icons.play_arrow),
      ],
    );
  }

  Widget _buildPlaybackButton(
      BuildContext context, String? assetPath, IconData? icon) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
            offset: const Offset(0, 0),
          ),
        ],
        shape: BoxShape.circle,
        color: AppColor.primaryColor,
      ),
      child: IconButton(
        icon: icon != null
            ? Icon(icon, color: Colors.white)
            : Image.asset(assetPath!, color: Colors.white),
        onPressed:
            icon != null ? () => GoRouter.of(context).go('/player') : null,
      ),
    );
  }
}
