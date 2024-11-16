import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/data/models/song.dart';
import 'package:sound_sphere/presentation/views/main/home/components/add_music_success_dialog.dart';
import 'package:sound_sphere/presentation/widgets/track/track_button_sheet_button.dart';

// ignore: must_be_immutable
class TrackItem extends StatefulWidget {
  Song song;
  bool isLiked;
  TrackItem({super.key, required this.song, required this.isLiked});

  @override
  State<TrackItem> createState() => _TrackItemState();
}

class _TrackItemState extends State<TrackItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.grey[100]!),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              SizedBox(
                height: 80,
                width: 80,
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
                  const Spacer(),
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
                  SizedBox(
                    width: 170,
                    child: Text(
                      widget.song.artistName,
                      style: TextStyle(color: AppColor.inkGreyDark),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const Spacer(),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: IconButton(
                  key: ValueKey<bool>(widget.isLiked),
                  onPressed: () {
                    setState(() {
                      widget.isLiked = !widget.isLiked;
                    });
                    if (widget.isLiked) {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              const AddMusicSuccessfulyDialog());
                    }
                  },
                  icon: Icon(widget.isLiked ? Icons.check : Icons.add),
                  color: Colors.grey,
                ),
              ),
              IconButton(
                onPressed: () {
                  showTrackInfoBottomModal(context);
                },
                icon: const Icon(Icons.more_horiz_rounded),
                color: Colors.grey,
              ),
            ],
          ),
        ));
  }

  Future<dynamic> showTrackInfoBottomModal(BuildContext context) {
    return showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      builder: (BuildContext context) {
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
                height: 5,
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
                    //track info
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
                                  style: TextStyle(fontWeight: FontWeight.w500),
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
                                Text(widget.song.artistName,
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
                    const SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          TrackBottomSheetButton(
                              buttonText: "Like", isLiked: true),
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
                      child: TrackBottomSheetButton(
                          buttonText: "About track", isLiked: true),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
