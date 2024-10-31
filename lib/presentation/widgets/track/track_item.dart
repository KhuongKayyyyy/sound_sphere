import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/data/models/song.dart';
import 'package:sound_sphere/presentation/views/home/components/add_music_success_dialog.dart';
import 'package:sound_sphere/presentation/widgets/track/track_button_sheet_button.dart';

// ignore: must_be_immutable
class TrackItem extends StatelessWidget {
  Song song;
  bool isLiked;
  TrackItem({super.key, required this.song, required this.isLiked});
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
                    imageUrl: song.imgURL,
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
                  Text(
                    song.title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    song.artistName,
                    style: TextStyle(color: AppColor.inkGreyDark),
                  ),
                  const Spacer(),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => const AddMusicSuccessfulyDialog());
                },
                icon: Icon(isLiked ? Icons.add : Icons.check),
                color: Colors.grey,
              ),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Track",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                song.title,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              Text(song.artistName,
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                imageUrl: song.imgURL,
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
                                            buttonText: "Download",
                                            isLiked: true),
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
                                            buttonText: "View Artist",
                                            isLiked: true),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const SizedBox(
                                    width: double.infinity,
                                    child: TrackBottomSheetButton(
                                        buttonText: "About track",
                                        isLiked: true),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.more_horiz_rounded),
                color: Colors.grey,
              ),
            ],
          ),
        ));
  }
}
