import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/presentation/views/main/search/components/app_search_bar.dart';
import 'package:sound_sphere/presentation/views/main/search/components/search_by_category.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ScrollController? _scrollController;
  bool hideAppBarTitle = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController!.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController!.removeListener(_onScroll);
    _scrollController!.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController!.offset > 30 && !hideAppBarTitle) {
      setState(() {
        hideAppBarTitle = true;
      });
    } else if (_scrollController!.offset <= 30 && hideAppBarTitle) {
      setState(() {
        hideAppBarTitle = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        const SliverToBoxAdapter(
          child: SizedBox(height: 30),
        ),
        // Persistent header for the search bar
        SliverPersistentHeader(
          pinned: true,
          delegate: SearchBarHeaderDelegate(
            hideAppBarTitle: hideAppBarTitle,
            onTap: () {
              context.pushNamed(Routes.intoSearch);
            },
          ),
        ),
        // Main content
        SliverToBoxAdapter(
          child: SizedBox(
            height: 2800,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SearchByCategory(),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: const SizedBox(height: 120),
        ),
      ],
    );
  }
}

// Custom delegate for the persistent search bar
class SearchBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  final bool hideAppBarTitle;
  final VoidCallback onTap;

  SearchBarHeaderDelegate({
    required this.hideAppBarTitle,
    required this.onTap,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white.withOpacity(0.95),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          AnimatedOpacity(
            opacity: hideAppBarTitle ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 300),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Search',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Hero(
            tag: 'search_bar',
            child: AppSearchBar(
              onTap: onTap,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 140;

  @override
  double get minExtent => 120;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
