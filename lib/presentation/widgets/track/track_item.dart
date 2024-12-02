import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/controller/player_controller.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/presentation/widgets/track/track_button_sheet_button.dart';

// ignore: must_be_immutable
class TrackItem extends StatefulWidget {
  Track song;
  bool isLiked;
  bool? isSliable;
  int? index;
  TrackItem(
      {super.key,
      required this.song,
      required this.isLiked,
      this.index,
      this.isSliable});

  @override
  State<TrackItem> createState() => _TrackItemState();
}

class _TrackItemState extends State<TrackItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.isSliable == false
            ? InkWell(
                onTap: () {
                  PlayerController().setPlayerAudio([widget.song]);
                  PlayerController().play();
                },
                child: _buildTrackInfo(context),
              )
            : Slidable(
                key: Key(widget.song.id.toString()),
                startActionPane: handleAddToCurrentPlaylist(),
                endActionPane: handleAddToLibrary(),
                child: InkWell(
                  onTap: () {
                    PlayerController().setPlayerAudio([widget.song]);
                    PlayerController().play();
                  },
                  child: _buildTrackInfo(context),
                ),
              ),
        // Divider
        // Padding(
        //   padding: const EdgeInsets.only(left: 80),
        //   child: const Divider(
        //     height: 2,
        //     thickness: 1,
        //     color: Colors.grey,
        //   ),
        // ),
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
              widget.isLiked = !widget.isLiked;
              print("Liked: ${widget.isLiked}");
            });
          },
          foregroundColor: AppColor.primaryColor,
          icon: Icons.add,
          label: 'Add to Library',
        ),
      ],
    );
  }

  ActionPane handleAddToCurrentPlaylist() {
    return ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: (BuildContext context) {
            print("Added to current playlist");
          },
          foregroundColor: AppColor.primaryColor,
          icon: CupertinoIcons.square_fill_line_vertical_square,
        ),
        SlidableAction(
          onPressed: (BuildContext context) {
            print("Added to new playlist");
          },
          foregroundColor: AppColor.primaryColor,
          icon: CupertinoIcons.square_line_vertical_square_fill,
        ),
        // SizedBox(
        //   width: 80,
        //   child: SlidableAction(
        //     onPressed: (BuildContext context) {},
        //     backgroundColor: Colors.purple,
        //     icon: CupertinoIcons.square_fill_line_vertical_square,
        //   ),
        // ),
        // SizedBox(
        //   width: 80,
        //   child: SlidableAction(
        //     onPressed: (BuildContext context) {},
        //     backgroundColor: Colors.yellow,
        //     icon: CupertinoIcons.square_line_vertical_square_fill,
        //   ),
        // ),
      ],
    );
  }

  Container _buildTrackInfo(BuildContext context) {
    Widget buildTrackImageOrIndex() {
      return SizedBox(
        height: 60,
        width: 60,
        child: widget.index != null
            ? Center(
                child: Text(
                  "${widget.index}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: widget.song.imgURL,
                  fit: BoxFit.cover,
                ),
              ),
      );
    }

    Widget buildTrackInfo() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 170,
            child: Text(
              widget.song.title,
              style: const TextStyle(fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            widget.song.artist.name!,
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

    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            buildTrackImageOrIndex(),
            const SizedBox(width: 10),
            buildTrackInfo(),
            const Spacer(),
            widget.isLiked ? buildIsLikedTrack() : const SizedBox.shrink(),
            buildTrackMenu(),
          ],
        ),
      ),
    );
  }

  FutureBuilder<dynamic> buildIsLikedTrack() {
    return FutureBuilder(
      future: Future.delayed(const Duration(milliseconds: 3)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: AppColor.primaryColor,
            ),
          );
        } else {
          return AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(seconds: 3),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[100],
              ),
              padding: const EdgeInsets.all(3),
              child: Icon(
                CupertinoIcons.down_arrow,
                color: Colors.grey,
                size: 15,
              ),
            ),
          );
        }
      },
    );
  }

  Future<dynamic> showTrackInfoBottomModal(BuildContext context) {
    bool isLiked = false;
    return showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            // Your stateful logic goes here

            return Container(
              height: 400,
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
                          height: 110,
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
                                    Text(
                                      widget.song.title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Text(widget.song.artist.name!,
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
                                      imageUrl: widget.song.imgURL,
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
                                buttonText: "Like",
                                isLiked: isLiked,
                                onPressed: () => setState(() {
                                  isLiked = !isLiked;
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
                        const SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              TrackBottomSheetButton(
                                  buttonText: "Share", isLiked: true),
                              Spacer(),
                              TrackBottomSheetButton(
                                  buttonText: "View Artist", isLiked: true),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              TrackBottomSheetButton(
                                  buttonText: "Add to Playlist", isLiked: true),
                              Spacer(),
                              TrackBottomSheetButton(
                                  buttonText: "About Track", isLiked: true),
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
}
