import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/controller/player_controller.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/presentation/blocs/library/library_bloc.dart';
import 'package:sound_sphere/presentation/views/playlist/add_to_a_playlist_page.dart';
import 'package:sound_sphere/presentation/widgets/context/track_item_context_menu.dart';
import 'package:sound_sphere/presentation/widgets/context/track_context_menu_action.dart';
import 'package:sound_sphere/presentation/widgets/toast/add_to_lib_toast.dart';
import 'package:sound_sphere/presentation/widgets/track/track_button_sheet_button.dart';

// ignore: must_be_immutable
class TrackItem extends StatefulWidget {
  bool? isFavorite;
  Color? backgroundColor;
  Track track;
  bool? isSliable;
  bool? isBlank;
  int? index;
  bool? isPreviewable;

  TrackItem(
      {super.key,
      this.backgroundColor,
      required this.track,
      this.index,
      this.isSliable,
      this.isPreviewable,
      this.isBlank,
      this.isFavorite});

  @override
  State<TrackItem> createState() => _TrackItemState();
}

class _TrackItemState extends State<TrackItem> {
  AudioPlayer? _audioPlayer;
  bool isPlaying = false;
  double progress = 0.0;
  Duration previewDuration = const Duration(seconds: 30);

  @override
  void dispose() {
    _audioPlayer?.dispose();
    super.dispose();
  }

  Future<void> _togglePreview() async {
    if (isPlaying) {
      await _audioPlayer?.pause();
      setState(() {
        isPlaying = false;
        progress = 0.0;
      });
    } else {
      _audioPlayer = AudioPlayer();
      await _audioPlayer!.setUrl(widget.track.urlMedia);
      _audioPlayer!.play();
      setState(() => isPlaying = true);

      _audioPlayer!.positionStream.listen((Duration position) {
        setState(() {
          progress = position.inMilliseconds / previewDuration.inMilliseconds;
        });
      });

      Future.delayed(previewDuration, () {
        _audioPlayer?.pause();
        setState(() {
          isPlaying = false;
          progress = 0.0;
        });
      });
    }
  }

  void _showToast() {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 150,
        left: MediaQuery.of(context).size.width * 0.5 - 75, // Center the toast
        child: AddToLibToast(),
      ),
    );

    Overlay.of(context).insert(overlayEntry);
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LibraryBloc, LibraryState>(
      listener: (context, state) {
        if (state is AddTrackToLibrarySuccess) {
          context.read<LibraryBloc>().add(GetTrackLibraryRequest());
          _showToast();
        } else if (state is AddTrackToLibraryError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Failed to add track to library: ${state.message}"),
            ),
          );
        }
      },
      child: Column(
        children: [
          widget.isSliable == false
              ? Material(
                  child: _buildTrackItemWithContextMenu(
                  child: InkWell(
                    onTap: () {
                      if (widget.isPreviewable == true) {
                        _togglePreview();
                      } else {
                        PlayerController().setPlayerAudio([widget.track]);
                        PlayerController().play();
                      }
                    },
                    child: _buildTrackInfo(context),
                  ),
                ))
              : _buildTrackItemWithContextMenu(
                  child: BlocBuilder<LibraryBloc, LibraryState>(
                    builder: (context, state) {
                      if (state is TrackLibraryLoaded) {
                        if (state.tracks.contains(widget.track)) {
                          return Slidable(
                            key: Key(widget.track.id.toString()),
                            startActionPane: handleAddToCurrentPlaylist(),
                            endActionPane: handleRemoveFromLib(),
                            child: InkWell(
                              onTap: () {
                                PlayerController()
                                    .setPlayerAudio([widget.track]);
                                PlayerController().play();
                              },
                              child: _buildTrackInfo(context),
                            ),
                          );
                        }
                      }
                      return Slidable(
                        key: Key(widget.track.id.toString()),
                        startActionPane: handleAddToCurrentPlaylist(),
                        endActionPane: handleAddToLibrary(),
                        child: InkWell(
                          onTap: () {
                            PlayerController().setPlayerAudio([widget.track]);
                            PlayerController().play();
                          },
                          child: _buildTrackInfo(context),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildTrackItemWithContextMenu({required Widget child}) {
    return Align(
      alignment: Alignment.topCenter,
      child: CupertinoContextMenu.builder(
        actions: [
          TrackContextMenuAction(
            track: widget.track,
          )
        ],
        builder: (context, animation) {
          if (animation.value < CupertinoContextMenu.animationOpensAt) {
            return Material(
              child: child,
            );
          }
          return TrackItemContextMenu(track: widget.track);
        },
      ),
    );
  }

  ActionPane handleRemoveFromLib() {
    return ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          flex: 2,
          onPressed: (BuildContext context) {
            showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) {
                return CupertinoActionSheet(
                  title: const Text('Confirm'),
                  message:
                      const Text('Are you sure you want to remove this track?'),
                  actions: [
                    CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.read<LibraryBloc>().add(
                              RemoveTrackFromLibRequest(widget.track.id!),
                            );
                        setState(() {
                          widget.isFavorite = false;
                        });
                      },
                      isDestructiveAction: true,
                      child: const Text('Remove'),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                );
              },
            );
          },
          foregroundColor: AppColor.primaryColor,
          icon: Icons.delete,
        ),
      ],
    );
  }

  ActionPane handleAddToLibrary() {
    return ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          flex: 2,
          onPressed: (BuildContext context) {
            setState(() {
              context.read<LibraryBloc>().add(
                    AddTrackToLibraryRequest(widget.track.id!),
                  );
            });
          },
          foregroundColor: AppColor.primaryColor,
          icon: Icons.add,
        ),
      ],
    );
  }

  ActionPane handleAddToCurrentPlaylist() {
    return ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: (BuildContext context) {},
          foregroundColor: AppColor.primaryColor,
          icon: CupertinoIcons.square_fill_line_vertical_square,
        ),
        SlidableAction(
          onPressed: (BuildContext context) {},
          foregroundColor: AppColor.primaryColor,
          icon: CupertinoIcons.square_line_vertical_square_fill,
        ),
      ],
    );
  }

  Widget _buildTrackInfo(BuildContext context) {
    Widget buildTrackImageOrIndex() {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.height * 0.08,
        child: widget.index != null
            ? Center(
                child: Text(
                  "${widget.index}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              )
            : Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: widget.track.imgURL,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        if (isPlaying)
                          Positioned.fill(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                              child: Container(
                                color: Colors.black
                                    .withOpacity(0.2), // Slight tint
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (isPlaying)
                    Container(
                      padding: const EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.height * 0.08,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: progress,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 5,
                            strokeCap: StrokeCap.round,
                            backgroundColor: Colors.grey.withOpacity(0.5),
                          ),
                          Icon(
                            Icons.pause,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
      );
    }

    Widget buildTrackInfo() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: Text(
              widget.track.title,
              style: const TextStyle(fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            widget.track.artist.name!,
            style: TextStyle(color: AppColor.inkGreyDark),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );
    }

    Widget buildTrackMenu() {
      return IconButton(
        onPressed: () {
          showTrackInfoBottomModal(context);
        },
        icon: const Icon(Icons.more_horiz_rounded),
        color: Colors.grey,
      );
    }

    return BlocBuilder<LibraryBloc, LibraryState>(
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.backgroundColor ?? Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                if (widget.isFavorite == true)
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.heart_fill,
                        color: AppColor.primaryColor,
                        size: 10,
                      ),
                      const SizedBox(width: 5),
                    ],
                  )
                else
                  SizedBox(width: 5),
                buildTrackImageOrIndex(),
                const SizedBox(width: 10),
                buildTrackInfo(),
                const Spacer(),
                if (widget.isBlank == true)
                  SizedBox.shrink()
                else
                  buildTrackMenu(),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> showTrackInfoBottomModal(BuildContext context) {
    return showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            // Your stateful logic goes here

            return Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              )),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 60,
                    height: 5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        // Track info
                        Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[100]),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Track",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: Text(
                                        widget.track.title,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                    Text(widget.track.artist.name!,
                                        style: TextStyle(
                                          color: AppColor.inkGrey,
                                        )),
                                  ],
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: widget.track.imgURL,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              TrackBottomSheetButton(
                                buttonText: widget.isFavorite == true
                                    ? "Favorited"
                                    : "Favorite",
                                isLiked: widget.isFavorite ?? false,
                                onPressed: () => setState(() {
                                  context.read<LibraryBloc>().add(
                                        ToggleTrackFavorite(
                                          track: widget.track,
                                          isFavorite:
                                              !(widget.isFavorite ?? false),
                                        ),
                                      );
                                  setState(() {
                                    widget.isFavorite =
                                        !(widget.isFavorite ?? false);
                                  });
                                }),
                              ),
                              Spacer(),
                              TrackBottomSheetButton(
                                  buttonText: "Download", isLiked: true),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              TrackBottomSheetButton(
                                  buttonText: "Share", isLiked: true),
                              Spacer(),
                              TrackBottomSheetButton(
                                buttonText: "View Artist",
                                isLiked: true,
                                onPressed: () {
                                  context.pop();
                                  context.pushNamed(
                                    Routes.artistDetail,
                                    extra: widget.track.artist,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              TrackBottomSheetButton(
                                  onPressed: () {
                                    context.pop();
                                    _showAddToPlaylistBottomModal(
                                        context, widget.track);
                                  },
                                  buttonText: "Add to Playlist",
                                  isLiked: true),
                              Spacer(),
                              TrackBottomSheetButton(
                                buttonText: "About Track",
                                isLiked: true,
                                onPressed: () {
                                  context.pop();
                                  context.pushNamed(
                                    Routes.creditPage,
                                    extra: {"track": widget.track},
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showAddToPlaylistBottomModal(BuildContext context, Track track) {
    showCupertinoModalBottomSheet(
        context: context,
        useRootNavigator: true,
        builder: (context) => AddToAPlaylistPage(
              track: track,
            ));
  }
}
