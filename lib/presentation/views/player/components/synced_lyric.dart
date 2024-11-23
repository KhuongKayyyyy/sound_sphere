import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sound_sphere/core/controller/player_controller.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/lyrics.dart';

class SyncedLyric extends StatefulWidget {
  final ScrollController lyricsScrollController;
  const SyncedLyric({super.key, required this.lyricsScrollController});

  @override
  State<SyncedLyric> createState() => _SyncedLyricState();
}

class _SyncedLyricState extends State<SyncedLyric> {
  List<Lyric>? lyrics;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();
  // StreamSubscription? streamSubscription;

  @override
  void initState() {
    super.initState();

    // Split the lyrics into lines and process each one
    lyrics = FakeData.soyLyricString
        .split('\n') // Split into individual lines
        .where((line) => RegExp(r'^\[\d{2}:\d{2}\.\d{2}\]')
            .hasMatch(line)) // Filter lines with valid timestamps
        .map((line) {
      final timeString = line.substring(1, 9); // Extract time: [00:09.66]
      final words = line.substring(10); // Extract text after the timestamp
      return Lyric(
        words,
        DateFormat("mm:ss.SS").parse(timeString),
      );
    }).toList();

    PlayerController().syncLyrics(
      lyrics: lyrics!,
      itemScrollController: itemScrollController,
    );
  }

  @override
  void dispose() {
    PlayerController().cancelLyricSync();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
        stream: PlayerController().audioPlayer.positionStream,
        builder: (context, snapshot) {
          return ScrollablePositionedList.builder(
            itemCount: lyrics!.length,
            itemBuilder: (context, index) {
              Duration duration = (snapshot.data ?? Duration.zero) +
                  Duration(milliseconds: 750);
              DateTime dt = DateTime(1970, 1, 1).copyWith(
                hour: duration.inHours,
                minute: duration.inMinutes.remainder(60),
                second: duration.inSeconds.remainder(60),
              );
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: InkWell(
                  onTap: () => PlayerController().seekTo(Duration(
                    hours: lyrics![index].timeStamp.hour,
                    minutes: lyrics![index].timeStamp.minute,
                    seconds: lyrics![index].timeStamp.second,
                    milliseconds: lyrics![index].timeStamp.millisecond,
                  )),
                  child: Text(
                    lyrics![index].words,
                    style: TextStyle(
                      color: lyrics![index].timeStamp.isAfter(dt)
                          ? Colors.white.withOpacity(0.3)
                          : Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              );
            },
            itemScrollController: itemScrollController,
            scrollOffsetController: scrollOffsetController,
            itemPositionsListener: itemPositionsListener,
            scrollOffsetListener: scrollOffsetListener,
          );
        });
  }
}
