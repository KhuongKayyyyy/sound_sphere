import 'package:flutter/material.dart';
import '../../../../widgets/app_bar_button.dart';

class AppBarSection extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const AppBarSection({
    required this.currentIndex,
    required this.onTabSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 50,
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AppBarButton(
            title: 'Listen Now',
            isActive: currentIndex == 0,
            onPressed: () => onTabSelected(0),
          ),
          AppBarButton(
            title: 'Shared',
            isActive: currentIndex == 1,
            onPressed: () => onTabSelected(1),
          ),
          AppBarButton(
            title: 'Playlists',
            isActive: currentIndex == 2,
            onPressed: () => onTabSelected(2),
          ),
          AppBarButton(
            title: 'Artists',
            isActive: currentIndex == 3,
            onPressed: () => onTabSelected(3),
          ),
        ],
      ),
      floating: true,
      pinned: true,
    );
  }
}
