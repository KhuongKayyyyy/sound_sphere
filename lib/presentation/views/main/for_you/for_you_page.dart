import 'package:flutter/material.dart';
import 'package:sound_sphere/presentation/views/main/for_you/components/for_you_app_bar.dart';
import 'package:sound_sphere/presentation/views/main/for_you/subpage/listen_now_page.dart';
import 'package:sound_sphere/presentation/widgets/app_bar_button.dart';

class ForYouPage extends StatefulWidget {
  const ForYouPage({super.key});

  @override
  State<ForYouPage> createState() => _ForYouPageState();
}

class _ForYouPageState extends State<ForYouPage> {
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
          if (_currentIndex == 0) const ListenNowPage(),
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
