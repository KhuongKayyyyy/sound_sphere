import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/controller/player_controller.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:sound_sphere/presentation/views/main_wrapper/components/bottom_navigation_bar.dart';
import 'package:sound_sphere/presentation/views/main_wrapper/components/music_player.dart';
import 'package:sound_sphere/presentation/widgets/context/track_item_context_menu.dart';

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

  final PlayerController _playerController = PlayerController();
  bool _isPlaying = false;
  bool _isSignedIn = false;
  @override
  void initState() {
    super.initState();
    // _scaleController = AnimationController(
    //   duration: const Duration(milliseconds: 200),
    //   vsync: this,
    // );

    _playerController.setPlayerAudio(FakeData.obitoSongs);

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
      body: Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: widget.navigationShell), // Use the navigation shell
      bottomNavigationBar: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, authState) {
          if (authState is AuthGetUserSuccess) {
            _isSignedIn = true;
          } else {
            _isSignedIn = false;
          }
          return SizedBox(
            height: _isSignedIn ? 140 : 80,
            child: Stack(
              children: [
                Positioned(
                    bottom: 0,
                    child: BottomNavigationBarWidget(
                      widget: widget,
                      isSignedIn: _isSignedIn,
                    )),
                // Mini music player at the top of the bottom navigation bar
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: _isSignedIn
                      ? CupertinoContextMenu.builder(
                          builder: (context, animation) {
                            if (animation.value <
                                CupertinoContextMenu.animationOpensAt) {
                              return MusicPlayerWidget(
                                  playMusic: _playMusic,
                                  isPlaying: _isPlaying,
                                  playerController: _playerController);
                            }
                            return TrackItemContextMenu(
                                track: PlayerController().getCurrentSong());
                          },
                          actions: [
                            CupertinoContextMenuAction(
                              child: const Text('Play'),
                              onPressed: () {},
                            ),
                          ],
                        )
                      : SizedBox(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
