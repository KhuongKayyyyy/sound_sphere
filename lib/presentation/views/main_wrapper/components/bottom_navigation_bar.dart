import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final bool isSignedIn;
  final dynamic widget;
  const BottomNavigationBarWidget(
      {super.key, required this.widget, required this.isSignedIn});

  // bool _isSignedIn = false;
  Widget _buildNavigationIcon({
    required dynamic icon, // Accept both IconData and String (for asset path)
    required String label,
    required int index,
    required dynamic widget,
  }) {
    bool isSelected = widget.navigationShell.currentIndex == index;

    return InkWell(
      onTap: () => isSignedIn ? _onTabTapped(index, widget) : null,
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

  @override
  Widget build(BuildContext context) {
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
                widget: widget,
              ),
              _buildNavigationIcon(
                icon: AppIcon
                    .browse, // Assuming AppIcon.browse is an Image or Icon
                label: "Browse",
                index: 1,
                widget: widget,
              ),
              _buildNavigationIcon(
                icon: Icons.favorite,
                label: "For you",
                index: 2,
                widget: widget,
              ),
              _buildNavigationIcon(
                icon: AppIcon.library,
                label: "Library",
                index: 3,
                widget: widget,
              ),
              _buildNavigationIcon(
                icon: Icons.search,
                label: "Search",
                index: 4,
                widget: widget,
              ),
            ],
          )),
    );
  }

  void _onTabTapped(int index, dynamic widget) {
    widget.navigationShell.goBranch(index,
        initialLocation: index == widget.navigationShell.currentIndex);
  }
}
