import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/views/main/library/components/library_header.dart';
import 'package:sound_sphere/presentation/views/main/library/components/search_bar_delegate.dart';
import 'package:sound_sphere/presentation/widgets/button/primary_button.dart';
import 'package:sound_sphere/presentation/widgets/track/track_item.dart';

class LibrarySongPage extends StatefulWidget {
  const LibrarySongPage({super.key});

  @override
  State<LibrarySongPage> createState() => _LibrarySongPageState();
}

class _LibrarySongPageState extends State<LibrarySongPage> {
  final ScrollController _scrollController = ScrollController();
  bool isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset > 50 && !isScrolled) {
      setState(() {
        isScrolled = true;
      });
    } else if (_scrollController.offset <= 50 && isScrolled) {
      setState(() {
        isScrolled = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              LibraryPlaylistHeader(isScrolled: isScrolled, title: "Songs"),
              SliverPersistentHeader(
                pinned: true,
                delegate: SearchBarDelegate(),
              ),
            ];
          },
          body: SingleChildScrollView(
              child: Column(children: [
            _buildPlaySection(),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: FakeData.wrxdieSong.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TrackItem(
                      track: FakeData.wrxdieSong.elementAt(index),
                    ),
                  );
                }),
            Container(
              color: Colors.white,
              height: 150,
            ),
          ]))),
    );
  }

  Widget _buildPlaySection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Row(
        children: [
          PrimaryButton(icon: AppIcon.play, text: "Play", onTap: () {}),
          PrimaryButton(icon: AppIcon.shuffle, text: "Shuffle", onTap: () {})
        ],
      ),
    );
  }
}
