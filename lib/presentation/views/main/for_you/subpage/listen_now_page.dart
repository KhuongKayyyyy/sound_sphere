import 'package:flutter/material.dart';
import 'package:sound_sphere/presentation/views/main/for_you/components/for_you_mix_playlist_section.dart';
import 'package:sound_sphere/presentation/views/main/for_you/components/listen_now_header.dart';
import 'package:sound_sphere/presentation/views/main/for_you/components/listen_now_notification.dart';
import 'package:sound_sphere/presentation/views/main/for_you/components/year_replay_button.dart';
import 'package:sound_sphere/presentation/views/main/for_you/subpage/year_replay_bottom_modal.dart';

class ListenNowPage extends StatefulWidget {
  const ListenNowPage({super.key});

  @override
  State<ListenNowPage> createState() => _ListenNowPageState();
}

class _ListenNowPageState extends State<ListenNowPage>
    with SingleTickerProviderStateMixin {
  bool _showNotification = true;
  late AnimationController _controller;
  late Animation<Offset> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _bounceAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -0.05),
    ).chain(CurveTween(curve: Curves.bounceOut)).animate(_controller);
  }

  void _removeNotification() {
    setState(() {
      _showNotification = false;
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        child: SlideTransition(
          position: _bounceAnimation,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: ListenNowHeader(),
              ),
              if (_showNotification)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListenNowNotification(
                    onDismiss: _removeNotification,
                  ),
                ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: YearReplayButton(
                  onPressed: () => showYearReplayBottomModal(context),
                ),
              ),
              ForYouMixPlaylistSection(),
            ],
          ),
        ),
      ),
    );
  }

  void showYearReplayBottomModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => YearReplayBottomModal(),
    );
  }
}
