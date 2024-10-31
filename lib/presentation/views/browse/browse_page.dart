import 'package:flutter/material.dart';
import 'package:sound_sphere/presentation/views/browse/subpage/browse_chart_page.dart';
import 'package:sound_sphere/presentation/views/browse/subpage/browse_genre_page.dart';
import 'components/app_bar.dart';
import 'subpage/browse_home_page.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  int _currentIndex = 0;
  bool showAppBarTitle = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 250 && !showAppBarTitle) {
      setState(() => showAppBarTitle = true);
    } else if (_scrollController.offset <= 250 && showAppBarTitle) {
      setState(() => showAppBarTitle = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          AppBarSection(
            currentIndex: _currentIndex,
            onTabSelected: (index) => setState(() => _currentIndex = index),
          ),
          if (_currentIndex == 0) const BrowseHomePage(),
          if (_currentIndex == 2) const BrowseGenresPage(),
          if (_currentIndex == 3) const BrowseChartPage(),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              height: 150,
            ),
          ),
        ],
      ),
    );
  }
}
