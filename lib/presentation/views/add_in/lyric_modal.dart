import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/presentation/blocs/track/track_bloc.dart';
import 'package:sound_sphere/presentation/views/add_in/share_lyric_modal.dart';

class LyricModal extends StatefulWidget {
  final Track track;

  const LyricModal({super.key, required this.track});

  @override
  State<LyricModal> createState() => _LyricModalState();
}

class _LyricModalState extends State<LyricModal> {
  String lyrics = '';
  late TrackBloc _trackBloc;
  @override
  void initState() {
    super.initState();

    _trackBloc = TrackBloc();
    _trackBloc.add(FetchTrackLyrics(widget.track.id!));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      height: MediaQuery.of(context).size.height * 0.93,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(),
          _buildSongInfo(context),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              height: 2,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[300],
            ),
          ),
          BlocBuilder<TrackBloc, TrackState>(
            bloc: _trackBloc,
            builder: (context, lyricState) {
              if (lyricState is TrackLyricsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (lyricState is TrackLyricsError) {
                return Center(
                  child: Text(
                    lyricState.message,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                );
              } else if (lyricState is TrackLyricsLoaded) {
                lyrics = lyricState.lyrics;
                return Expanded(
                    child: SingleChildScrollView(
                  child: Text(
                    lyrics,
                    style: const TextStyle(
                      fontSize: 20,
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ));
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }

  Row _buildSongInfo(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            widget.track.imgURL,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.track.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                widget.track.artist.name!,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildAppBarButton(() {
          shareLyricBottomModalSheet();
        }, CupertinoIcons.share),
        const SizedBox(width: 15),
        _buildAppBarButton(() {
          context.pop();
        }, CupertinoIcons.xmark)
      ],
    );
  }

  InkWell _buildAppBarButton(VoidCallback onTap, IconData icon) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.inkGreyLight,
        ),
        padding: const EdgeInsets.all(5),
        child: Icon(icon, color: Colors.grey),
      ),
    );
  }

  Future<void> shareLyricBottomModalSheet() {
    return showModalBottomSheet(
      useRootNavigator: true,
      isScrollControlled: true, // Allow full screen height
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          ShareLyricModal(lyrics: lyrics, imageUrl: widget.track.imgURL),
    );
  }
}
