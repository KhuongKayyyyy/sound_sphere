import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/controller/player_controller.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/presentation/views/main/home/components/add_music_success_dialog.dart';
import 'package:sound_sphere/presentation/widgets/track/track_button_sheet_button.dart';

// ignore: must_be_immutable
class TrackItem extends StatefulWidget {
  Track song;
  bool isLiked;
  TrackItem({super.key, required this.song, required this.isLiked});

  @override
  State<TrackItem> createState() => _TrackItemState();
}

class _TrackItemState extends State<TrackItem> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SizedBox(
            width: 80,
            child: SlidableAction(
              onPressed: (BuildContext context) {},
              backgroundColor: Colors.purple,
              icon: CupertinoIcons.square_fill_line_vertical_square,
            ),
          ),
          SizedBox(
            width: 80,
            child: SlidableAction(
              onPressed: (BuildContext context) {},
              backgroundColor: Colors.yellow,
              icon: CupertinoIcons.square_line_vertical_square_fill,
            ),
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
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
      ),
      child: InkWell(
        onTap: () {
          PlayerController().setPlayerAudio([widget.song]);
          PlayerController().play();
        },
        child: Container(
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: widget.song.imgURL,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: Text(
                          widget.song.artist,
                          style: TextStyle(color: AppColor.inkGreyDark),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  widget.isLiked
                      ? FutureBuilder(
                          future:
                              Future.delayed(const Duration(milliseconds: 3)),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
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
                        )
                      : const SizedBox.shrink(),
                  IconButton(
                    onPressed: () {
                      showTrackInfoBottomModal(context);
                    },
                    icon: const Icon(Icons.more_horiz_rounded),
                    color: Colors.grey,
                  ),
                ],
              ),
            )),
      ),
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
                                    Text(widget.song.artist,
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
