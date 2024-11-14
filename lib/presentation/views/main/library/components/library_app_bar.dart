import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/presentation/views/main/library/components/library_app_bar_button.dart';

class LibraryAppBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final bool showAppBarTitle;

  const LibraryAppBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
    required this.showAppBarTitle,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      pinned: true,
      toolbarHeight: 50,
      expandedHeight: !showAppBarTitle ? 125 : 50,
      backgroundColor: Colors.white.withOpacity(0.9),
      centerTitle: true,
      title: showAppBarTitle
          ? Text(
              currentIndex == 0
                  ? 'Albums'
                  : currentIndex == 1
                      ? 'Artists'
                      : 'Genres',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )
          : null,
      actions: showAppBarTitle
          ? [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColor.primaryColor),
                  color: Colors.white,
                ),
                child: Image.asset(
                  AppIcon.play,
                  width: 15,
                  height: 15,
                  color: AppColor.primaryColor,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColor.primaryColor),
                    color: Colors.white),
                child: Image.asset(
                  AppIcon.shuffle,
                  width: 15,
                  height: 15,
                  color: AppColor.primaryColor,
                ),
              ),
              const SizedBox(width: 10),
            ]
          : [],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: !showAppBarTitle
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => onTabSelected(0),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: currentIndex == 0
                                  ? AppColor.primaryColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.asset(
                              AppIcon.stack,
                              color: currentIndex == 0
                                  ? Colors.white
                                  : AppColor.primaryColor,
                              width: 30,
                              height: 30,
                            ),
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () => onTabSelected(1),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: currentIndex == 1
                                  ? AppColor.primaryColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.asset(
                              AppIcon.arrowUpDown,
                              color: currentIndex == 1
                                  ? Colors.white
                                  : AppColor.primaryColor,
                              width: 30,
                              height: 30,
                            ),
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () => onTabSelected(2),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: currentIndex == 2
                                  ? AppColor.primaryColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.asset(
                              AppIcon.micro,
                              color: currentIndex == 2
                                  ? Colors.white
                                  : AppColor.primaryColor,
                              width: 30,
                              height: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          currentIndex == 0
                              ? 'Albums'
                              : currentIndex == 1
                                  ? 'Artists'
                                  : 'Genres',
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const Spacer(),
                        LibraryAppBarButton(icon: AppIcon.shuffle),
                        const SizedBox(width: 10),
                        LibraryAppBarButton(icon: AppIcon.play),
                      ],
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }
}

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  int _currentIndex = 0;
  bool showAppBar = false;
  late final ScrollController _scrollController;
  double previousScrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    double currentOffset = _scrollController.offset;
    bool isScrollingDown = currentOffset > previousScrollOffset;

    if (isScrollingDown && currentOffset > 120 && !showAppBar) {
      setState(() {
        showAppBar = true;
      });
    } else if (!isScrollingDown && currentOffset <= 120 && showAppBar) {
      setState(() {
        showAppBar = false;
      });
    }

    previousScrollOffset = currentOffset;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          LibraryAppBar(
            currentIndex: _currentIndex,
            onTabSelected: (int value) {
              setState(() {
                _currentIndex = value;
              });
            },
            showAppBarTitle: showAppBar,
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.black,
              height: 2000,
            ),
          ),
        ],
      ),
    );
  }
}
