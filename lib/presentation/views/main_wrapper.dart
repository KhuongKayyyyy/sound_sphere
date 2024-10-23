import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/constant/app_image.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});
  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green[200],
      appBar: AppBar(
        title: const Text('Main Wrapper'),
      ),
      body: const Center(
        child: Text('Main Wrapper'),
      ),
      bottomNavigationBar: SizedBox(
        height: 140,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 110,
                color: Colors.grey.withOpacity(0.2),
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          print("home");
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.play_circle_fill_rounded,
                              size: 28,
                              color: Colors.grey.withOpacity(0.4),
                            ),
                            Text(
                              "Home",
                              style: TextStyle(
                                  color: Colors.grey.withOpacity(0.8)),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print("browse");
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppIcon.browse,
                              height: 25,
                              color: Colors.grey.withOpacity(0.4),
                            ),
                            Text(
                              "Browse",
                              style: TextStyle(
                                  color: Colors.grey.withOpacity(0.8)),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print("Library");
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Icon(
                            //   Icons.search,
                            //   size: 28,
                            //   color: Colors.grey.withOpacity(0.4),
                            // ),
                            Image.asset(
                              AppIcon.library,
                              height: 25,
                              color: Colors.grey.withOpacity(0.4),
                            ),
                            Text(
                              "Search",
                              style: TextStyle(
                                  color: Colors.grey.withOpacity(0.8)),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print("search");
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              size: 25,
                              color: Colors.grey.withOpacity(0.4),
                            ),
                            Text(
                              "Search",
                              style: TextStyle(
                                  color: Colors.grey.withOpacity(0.8)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 3,
                      ),
                    ]),
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 3,
                        ),
                      ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          FakeData.songs.first.imgURL,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          FakeData.songs.first.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(FakeData.songs.first.artistName,
                            style: TextStyle(
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Spacer(),
                    InkWell(
                      child: Image.asset(
                        AppIcon.play,
                        height: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      child: Image.asset(
                        AppIcon.play_next,
                        height: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
