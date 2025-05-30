import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sound_sphere/core/constant/api_config.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/constant/app_image.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/artist.dart';
import 'package:sound_sphere/data/models/user_playlist.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:sound_sphere/presentation/blocs/playlist/playlist_bloc.dart';
import 'package:sound_sphere/presentation/blocs/track/track_bloc.dart';
import 'package:sound_sphere/presentation/views/artist_detail/components/artist_rounded_avatar.dart';
import 'package:sound_sphere/presentation/widgets/button/primary_button.dart';
import 'package:sound_sphere/presentation/widgets/track/track_item.dart';

class PlaylistDetailPage extends StatefulWidget {
  final UserPlaylist playlist;
  const PlaylistDetailPage({super.key, required this.playlist});

  @override
  State<PlaylistDetailPage> createState() => _PlaylistDetailPageState();
}

class _PlaylistDetailPageState extends State<PlaylistDetailPage> {
  late PlaylistBloc _playlistBloc;
  late TrackBloc trackBloc;
  late ScrollController _scrollController;
  bool _showTitle = false;
  @override
  void initState() {
    super.initState();
    _playlistBloc = PlaylistBloc();
    _playlistBloc.add(PLGetDetailRequested(widget.playlist));

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    trackBloc = TrackBloc();
    trackBloc.add(FetchTracksEvent(0, 0, TrackApi.previewTrack));
    final int page = Random().nextInt(25) + 1;

    trackBloc.add(FetchTracksEvent(page, 5, TrackApi.previewTrack));
  }

  void _scrollListener() {
    if (_scrollController.offset > 200 && !_showTitle) {
      setState(() {
        _showTitle = true;
      });
    } else if (_scrollController.offset <= 200 && _showTitle) {
      setState(() {
        _showTitle = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<PlaylistBloc, PlaylistState>(
            bloc: _playlistBloc,
            listener: (context, state) {
              if (state is PLRemoveTrackSuccess) {
                EasyLoading.showSuccess("Track removed");
                _playlistBloc.add(
                    PLGetDetailRequested(state.playlist)); // Re-fetch tracks
              } else if (state is PLRemoveTrackFailure) {
                EasyLoading.showError(state.message);
              } else if (state is PLRemoveTrackLoading) {
                EasyLoading.show(status: "Removing track...");
              } else if (state is PLDeleteSuccess) {
                EasyLoading.showSuccess("Playlist deleted");
                context.read<PlaylistBloc>().add(PlaylistGetListRequested());
                context.pop();
              } else if (state is PLDeleteFailure) {
                EasyLoading.showError(state.message);
              } else if (state is PLDeleteLoading) {
                EasyLoading.show(status: "Deleting playlist...");
              } else if (state is PLAddTrackSuccess) {
                EasyLoading.showSuccess("Track added");
                _playlistBloc.add(PLGetDetailRequested(state.playlist));
              } else if (state is PLAddTrackFailure) {
                EasyLoading.showError(state.message);
              } else if (state is PLAddTrackLoading) {
                EasyLoading.show(status: "Adding track...");
              }
            },
          ),
        ],
        child: CupertinoPageScaffold(
          navigationBar: _buildAppBar(context),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _buildHeader(),
                _buildPlaySection(),
                Divider(
                  height: 1,
                  thickness: 0.5,
                ),
                _buildPlaylistSongSection(),
                _buildSuggestSection(),
                _buildFeaturedArtistSection(),
              ],
            ),
          ),
        ));
  }

  Widget _buildFeaturedArtistSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[200],
      height: 350,
      width: double.infinity,
      child: BlocBuilder<PlaylistBloc, PlaylistState>(
        bloc: _playlistBloc,
        builder: (context, state) {
          if (state is PLGetDetailSuccess) {
            return _buildFeaturedArtistList(state.artists);
          } else if (state is PlaylistLoading) {
            return Skeletonizer(
              enabled: true,
              child: _buildFeaturedArtistList(FakeData.artists),
            );
          } else if (state is PLGetDetailFailure) {
            return Center(
              child: Text("Error"),
            );
          } else {
            return SizedBox(
              height: 350,
              child: Center(
                child: Text("No event added"),
              ),
            );
          }
        },
      ),
    );
  }

  Column _buildFeaturedArtistList(List<Artist> artists) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Featured Artists",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
        ),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(16),
              scrollDirection: Axis.horizontal,
              itemCount: artists.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ArtistRoundedAvatar(
                      artist: artists.elementAt(index),
                      isLike: false,
                      onTap: () {
                        context.pushNamed(Routes.artistDetail,
                            extra: artists[index]);
                      },
                    ),
                  )),
        ),
      ],
    );
  }

  CupertinoNavigationBar _buildAppBar(BuildContext context) {
    return CupertinoNavigationBar(
      backgroundColor: Colors.white,
      leading: InkWell(
          onTap: () {
            context.pop();
          },
          child: Icon(
            CupertinoIcons.back,
            color: AppColor.primaryColor,
          )),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          appBarButton(CupertinoIcons.person_add_solid, () {
            // Add your action here
          }),
          appBarButton(CupertinoIcons.arrow_down_to_line_alt, () {
            // Add your action here
          }),
          appBarButton(Icons.more_horiz_rounded, () {
            // Add your action here
            _showPlaylistMenu(context);
          }),
        ],
      ),
      middle: AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        opacity: _showTitle ? 1.0 : 0.0,
        child: Text(
          widget.playlist.name!,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Future<dynamic> _showPlaylistMenu(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                // Add your action for "Edit Playlist" here
              },
              child: Text("Edit Playlist"),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                // Add your action for "Share Playlist" here
              },
              child: Text("Share Playlist"),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                // Add your action for "Delete Playlist" here
                _showDeletePlaylistDialog();
              },
              isDestructiveAction: true,
              child: Text("Delete Playlist"),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
        );
      },
    );
  }

  void _showDeletePlaylistDialog() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocListener<PlaylistBloc, PlaylistState>(
          bloc: _playlistBloc,
          listener: (context, state) {
            if (state is PLDeleteSuccess) {
              EasyLoading.showSuccess("Playlist deleted");
              context.read<PlaylistBloc>().add(PlaylistGetListRequested());
            } else if (state is PLDeleteFailure) {
              EasyLoading.showError(state.message);
            } else if (state is PLDeleteLoading) {
              // EasyLoading.show(status: "Deleting playlist...");
            }
          },
          child: CupertinoAlertDialog(
            title: Text("Confirm"),
            content: Text("Are you sure you want to delete this playlist?"),
            actions: [
              CupertinoDialogAction(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                child: Text("Delete", style: TextStyle(color: Colors.red)),
                onPressed: () {
                  _playlistBloc
                      .add(PLDeleteRequested(playlistId: widget.playlist.id!));
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSuggestSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[100],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Suggested for you",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Preview and add to your playlist",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  final int page = Random().nextInt(25) + 1;
                  trackBloc
                      .add(FetchTracksEvent(page, 5, TrackApi.previewTrack));
                },
                child: Icon(
                  Icons.replay_outlined,
                  color: AppColor.primaryColor,
                ),
              ),
            ],
          ),
          BlocBuilder<TrackBloc, TrackState>(
            bloc: trackBloc,
            builder: (context, state) {
              if (state is TracksLoaded) {
                return _buildSuggestSongList(state.tracks);
              } else if (state is TracksLoading) {
                return Skeletonizer(
                  enabled: true,
                  child: _buildSuggestSongList(FakeData.gnxTracks),
                );
              } else if (state is TracksError) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return Skeletonizer(
                  enabled: true,
                  child: _buildSuggestSongList(FakeData.gnxTracks),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  ListView _buildSuggestSongList(List<Track> newTracks) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: newTracks.length,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Expanded(
              child: TrackItem(
                backgroundColor: Colors.grey[100],
                track: newTracks[index],
                isSliable: false,
                isBlank: true,
                isPreviewable: true,
              ),
            ),
            InkWell(
              onTap: () {
                _playlistBloc.add(PLAddTrackRequested(
                    playlistId: widget.playlist.id!,
                    trackId: newTracks[index].id!));
              },
              child: Icon(CupertinoIcons.plus_circle,
                  color: AppColor.primaryColor),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPlaylistSongSection() {
    return BlocBuilder<PlaylistBloc, PlaylistState>(
      bloc: _playlistBloc,
      builder: (context, playlistState) {
        if (playlistState is PLGetDetailSuccess) {
          return _buildSongList(playlistState.playlist);
        } else if (playlistState is PlaylistLoading) {
          return Skeletonizer(
            enabled: true,
            child: _buildSongList(FakeData.gnxTracks),
          );
        } else if (playlistState is PLGetDetailFailure) {
          return Center(
            child: Text("Error"),
          );
        } else {
          return Skeletonizer(
            enabled: true,
            child: _buildSongList(FakeData.gnxTracks),
          );
        }
      },
    );
  }

  Column _buildSongList(List<Track> newTracks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: newTracks.length,
          itemBuilder: (context, index) {
            return Slidable(
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    flex: 2,
                    onPressed: (context) {
                      showCupertinoDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            title: Text("Confirm"),
                            content: Text(
                                "Are you sure you want to delete this track?"),
                            actions: [
                              CupertinoDialogAction(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              CupertinoDialogAction(
                                child: Text("Delete",
                                    style: TextStyle(color: Colors.red)),
                                onPressed: () {
                                  _playlistBloc.add(PLRemoveTrackRequested(
                                      playlistId: widget.playlist.id!,
                                      trackId: newTracks[index].id!));
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    backgroundColor: AppColor.primaryColor,
                    foregroundColor: Colors.white,
                    icon: CupertinoIcons.minus_circle_fill,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TrackItem(
                  track: newTracks[index], // Update this line
                  isSliable: false,
                ),
              ),
            );
          },
        ),
        Divider(
          height: 1,
          thickness: 0.5,
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "Total ${newTracks.length} songs, 69 minutes",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }

  Widget _buildPlaySection() {
    return Row(
      children: [
        PrimaryButton(icon: AppIcon.play, text: "Play", onTap: () {}),
        PrimaryButton(icon: AppIcon.shuffle, text: "Shuffle", onTap: () {}),
      ],
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.playlist.imgURL != null)
              SizedBox(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    widget.playlist.imgURL!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        AppImage.logo, // Replace with your app logo asset path
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              )
            else
              Hero(
                tag: widget.playlist.id!,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
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
                      size: 40,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              widget.playlist.name!,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, authState) {
                if (authState is AuthGetUserSuccess) {
                  return Text(
                    authState.user.displayName,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }
                return Text(
                  "KhuongKayyy",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            Text(
              "Updated at ${widget.playlist.updatedAt!.day}/${widget.playlist.updatedAt!.month}/${widget.playlist.updatedAt!.year}",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell appBarButton(IconData icon, Function()? onTap) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Container(
        margin: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[200],
        ),
        width: 30,
        height: 30,
        child: Icon(
          icon,
          size: 15,
          color: AppColor.primaryColor,
        ),
      ),
    );
  }
}
