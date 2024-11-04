import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/presentation/views/player/player_page.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper>
    with SingleTickerProviderStateMixin {
  bool _isPlaying = false; // Track play/pause state
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 1.05).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.bounceInOut,
      ),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    widget.navigationShell.goBranch(index,
        initialLocation: index == widget.navigationShell.currentIndex);
  }

  void _showBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext builder) {
        return const CupertinoPopupSurface(child: PlayerPage());
      },
    ).whenComplete(() async {
      // Scale up the mini-player after modal is closed
      await _scaleController.forward();
      await Future.delayed(const Duration(milliseconds: 300));
      _scaleController.reverse(); // Scale back to normal after a delay
    });
  }

  Widget _buildMusicPlayer() {
    return ScaleTransition(
      scale: _scaleAnimation,
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
            Expanded(
              child: InkWell(
                onTap: () => _showBottomSheet(context),
                child: Row(
                  children: [
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
                        Text(
                          FakeData.songs.first.artistName,
                          style: TextStyle(
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Mini player buttons
            InkWell(
              onTap: _playMusic,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 0.7, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOut,
                        ),
                      ),
                      child: child,
                    ),
                  );
                },
                child: !_isPlaying
                    ? Image.asset(
                        AppIcon.play,
                        height: 20,
                        key: const ValueKey('playIcon'),
                      )
                    : const Icon(
                        Icons.pause_rounded,
                        size: 30,
                        key: ValueKey('pauseIcon'),
                      ),
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              child: Image.asset(
                AppIcon.play_next,
                height: 22,
              ),
            ),
          ],
        ),
      ),
    );
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
            Positioned(bottom: 0, child: _buildBottomNavigationBar()),
            // Mini music player at the top of the bottom navigation bar
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: _buildMusicPlayer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
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
            _buildNavigationIcon(
              icon: Icons.play_circle_fill_rounded,
              label: "Home",
              index: 0,
            ),
            _buildNavigationIcon(
              icon:
                  AppIcon.browse, // Assuming AppIcon.browse is an Image or Icon
              label: "Browse",
              index: 1,
            ),
            _buildNavigationIcon(
              icon: Icons.favorite,
              label: "For you",
              index: 2,
            ),
            _buildNavigationIcon(
              icon: AppIcon.library,
              label: "Library",
              index: 3,
            ),
            _buildNavigationIcon(
              icon: Icons.search,
              label: "Search",
              index: 4,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationIcon({
    required dynamic icon, // Accept both IconData and String (for asset path)
    required String label,
    required int index,
  }) {
    bool isSelected = widget.navigationShell.currentIndex == index;

    return InkWell(
      onTap: () => _onTabTapped(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(
                scale: Tween<double>(begin: 0.7, end: 1.0).animate(animation),
                child: child,
              );
            },
            child: isSelected
                ? _buildIcon(icon,
                    isSelected: true, key: ValueKey('$label-selected'))
                : _buildIcon(icon,
                    isSelected: false, key: ValueKey('$label-unselected')),
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? AppColor.primaryColor
                  : Colors.grey.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(dynamic icon,
      {required bool isSelected, required Key key}) {
    // Check if icon is a String (asset path) or IconData
    if (icon is String) {
      return Image.asset(
        icon,
        height: 28,
        color:
            isSelected ? AppColor.primaryColor : Colors.grey.withOpacity(0.4),
        key: key,
      );
    } else if (icon is IconData) {
      return Icon(
        icon,
        size: 28,
        color:
            isSelected ? AppColor.primaryColor : Colors.grey.withOpacity(0.4),
        key: key,
      );
    } else {
      return Container(); // fallback if icon type is unsupported
    }
  }

  void _playMusic() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }
}
