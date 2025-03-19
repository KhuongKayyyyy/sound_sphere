import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/data/models/playlist.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/presentation/blocs/playlist/playlist_bloc.dart';
import 'package:sound_sphere/presentation/views/main/library/components/playlist_add_new.dart';
import 'package:sound_sphere/presentation/widgets/playlist/horizontal_playlist_item.dart';

class AddToAPlaylistPage extends StatefulWidget {
  final Track track;
  const AddToAPlaylistPage({super.key, required this.track});

  @override
  State<AddToAPlaylistPage> createState() => _AddToAPlaylistPageState();
}

class _AddToAPlaylistPageState extends State<AddToAPlaylistPage> {
  @override
  void initState() {
    super.initState();
    final playlistBloc = context.read<PlaylistBloc>();

    if (playlistBloc.state is! PlaylistGetSuccess &&
        playlistBloc.state is! PlaylistLoading) {
      playlistBloc.add(PlaylistGetListRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlaylistBloc, PlaylistState>(
      listener: (context, state) {
        if (state is PLAddTrackLoading) {
          EasyLoading.show(status: "Adding to playlist...");
        } else if (state is PLAddTrackSuccess) {
          EasyLoading.dismiss();
          context.pop();
          _showSuccessToast(state.playlist);
        } else if (state is PLAddTrackFailure) {
          EasyLoading.dismiss();
          EasyLoading.showError(state.message);
        }
      },
      child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: AppColor.primaryColor),
                ),
              ),
            ),
            middle: const Text("Add to a Playlist"),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                PlaylistAddNew(),
                _buildPlaylistList(),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          )),
    );
  }

  void _showSuccessToast(Playlist playlist) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 200,
        left: MediaQuery.of(context).size.width * 0.25,
        child: buildToast(playlist),
      ),
    );

    Overlay.of(context).insert(overlayEntry);
    Future.delayed(Duration(seconds: 4), () {
      overlayEntry.remove();
    });
  }

  Widget buildToast(Playlist playlist) => Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColor.primaryColor,
                      AppColor.secondaryColor,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Icon(
                    CupertinoIcons.music_note_list,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Added to Playlist",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        playlist.name!,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        CupertinoIcons.chevron_right,
                        size: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget _buildPlaylistList() {
    return BlocBuilder<PlaylistBloc, PlaylistState>(
      builder: (context, playlistState) {
        if (playlistState is PlaylistGetSuccess) {
          return _buildList(playlistState.playlists);
        } else if (playlistState is PlaylistGetFailure) {
          return Center(
            child: Text(playlistState.message),
          );
        } else if (playlistState is PlaylistLoading) {
          return Skeletonizer(
              child: _buildList(List.generate(5, (index) => Playlist.empty())));
        }
        return Container();
      },
    );
  }

  Widget _buildList(List<Playlist> playlists) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "Your Playlists",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              children: [
                HorizontalPlaylistItem(
                  playlist: playlists[index],
                  onPressed: () {
                    _handleAddTrackToPlaylist(
                        playlistId: playlists.elementAt(index).id!,
                        trackId: widget.track.id!);
                  },
                ),
                Divider(
                  height: 1,
                  thickness: 0.5,
                ),
              ],
            );
          },
          itemCount: playlists.length,
        ),
      ],
    );
  }

  void _handleAddTrackToPlaylist(
      {required String playlistId, required String trackId}) {
    context
        .read<PlaylistBloc>()
        .add(PLAddTrackRequested(playlistId: playlistId, trackId: trackId));
  }
}
