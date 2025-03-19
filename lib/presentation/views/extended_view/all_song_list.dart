import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/presentation/widgets/track/track_item.dart';

class AllSongList extends StatefulWidget {
  final List<Track> tracks;
  final String title;

  const AllSongList({
    super.key,
    required this.tracks,
    required this.title,
  });

  @override
  State<AllSongList> createState() => _AllSongListState();
}

class _AllSongListState extends State<AllSongList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: _buildExistedPlaylist());
  }

  Widget _buildExistedPlaylist() {
    return ListView.builder(
      itemCount: widget.tracks.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TrackItem(
            track: widget.tracks.elementAt(index),
          ),
        );
      },
    );
  }
}
