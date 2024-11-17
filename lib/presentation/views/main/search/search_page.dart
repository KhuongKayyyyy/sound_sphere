import 'package:flutter/material.dart';
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
    // Check if the user has scrolled past 60 pixels
    if (_scrollController!.offset > 60 && !hideAppBarTitle) {
      setState(() {
        hideAppBarTitle = true;
      });
    } else if (_scrollController!.offset <= 60 && hideAppBarTitle) {
      setState(() {
        hideAppBarTitle = false;
      });
    }

    // Automatically expand the SliverAppBar when scrolling up and reaching the top
    if (_scrollController!.offset <= 0 && hideAppBarTitle) {
      setState(() {
        hideAppBarTitle = false; // Show the title again
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 150,
          backgroundColor: Colors.white.withOpacity(0.95),
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              // Calculate the collapse percentage
              double collapsePercentage =
                  (constraints.maxHeight - kToolbarHeight) /
                      (150 - kToolbarHeight);

              // Clamp the value between 0 and 1
              collapsePercentage = collapsePercentage.clamp(0.0, 1.0);

              return FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                centerTitle: true,
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedOpacity(
                      opacity: hideAppBarTitle ? 0.0 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        padding: const EdgeInsets.only(left: 20, bottom: 8),
                        width: double.infinity,
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 300),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                          child: const Text('Search'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AppSearchBar(
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              );
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
