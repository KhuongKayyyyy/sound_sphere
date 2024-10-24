import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/core/constant/app_color.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  // Navigation logic moved to GoRouter integration
  void _onTabTapped(int index) {
    widget.navigationShell.goBranch(index,
        initialLocation: index == widget.navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: widget.navigationShell, // Use the navigation shell
      bottomNavigationBar: SizedBox(
        height: 140,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.8),
                      Colors.white.withOpacity(1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Home Button
                      InkWell(
                        onTap: () {
                          _onTabTapped(0);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.play_circle_fill_rounded,
                              size: 28,
                              color: widget.navigationShell.currentIndex == 0
                                  ? AppColor.primaryColor
                                  : Colors.grey.withOpacity(0.4),
                            ),
                            Text(
                              "Home",
                              style: TextStyle(
                                color: widget.navigationShell.currentIndex == 0
                                    ? AppColor.primaryColor
                                    : Colors.grey.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Browse Button
                      InkWell(
                        onTap: () {
                          _onTabTapped(1);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppIcon.browse,
                              height: 25,
                              color: widget.navigationShell.currentIndex == 1
                                  ? AppColor.primaryColor
                                  : Colors.grey.withOpacity(0.4),
                            ),
                            Text(
                              "Browse",
                              style: TextStyle(
                                color: widget.navigationShell.currentIndex == 1
                                    ? AppColor.primaryColor
                                    : Colors.grey.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Library Button
                      InkWell(
                        onTap: () {
                          _onTabTapped(2);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppIcon.library,
                              height: 25,
                              color: widget.navigationShell.currentIndex == 2
                                  ? AppColor.primaryColor
                                  : Colors.grey.withOpacity(0.4),
                            ),
                            Text(
                              "Library",
                              style: TextStyle(
                                color: widget.navigationShell.currentIndex == 2
                                    ? AppColor.primaryColor
                                    : Colors.grey.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Search Button
                      InkWell(
                        onTap: () {
                          _onTabTapped(3);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              size: 25,
                              color: widget.navigationShell.currentIndex == 3
                                  ? AppColor.primaryColor
                                  : Colors.grey.withOpacity(0.4),
                            ),
                            Text(
                              "Search",
                              style: TextStyle(
                                color: widget.navigationShell.currentIndex == 3
                                    ? AppColor.primaryColor
                                    : Colors.grey.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Mini music player at the top of the bottom navigation bar
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
                  ],
                ),
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Mini player image
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
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
                    // Mini player text
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
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    const Spacer(),
                    // Mini player buttons
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
