import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/controller/player_controller.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/views/main_wrapper/components/bottom_navigation_bar.dart';
import 'package:sound_sphere/presentation/views/main_wrapper/components/music_player.dart';

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
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  final PlayerController _playerController = PlayerController();
  bool _isPlaying = false; // Track play/pause state

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

    _playerController.setPlayerAudio(FakeData.wrxdieSong);

    // Listen for changes in the playback state
    _playerController.audioPlayer.playerStateStream.listen((state) {
      final isPlaying = state.playing;
      if (mounted) {
        setState(() {
          _isPlaying = isPlaying;
        });
      }
    });
  }

  void _playMusic() async {
    setState(() {
      _isPlaying = !_isPlaying;
    });
    if (_isPlaying) {
      _playerController.play();
    } else {
      _playerController.pause();
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
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
            Positioned(
                bottom: 0, child: BottomNavigationBarWidget(widget: widget)),
            // Mini music player at the top of the bottom navigation bar
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: MusicPlayerWidget(
                  scaleAnimation: _scaleAnimation,
                  playMusic: _playMusic,
                  isPlaying: _isPlaying,
                  playerController: _playerController),
            ),
          ],
        ),
      ),
    );
  }
}
