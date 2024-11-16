import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/song.dart';
import 'package:sound_sphere/presentation/widgets/track/track_item.dart';

class AllSongList extends StatefulWidget {
  final List<Song> songs;
  final String title;
  const AllSongList({super.key, required this.songs, required this.title});

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
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.songs.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child:
                TrackItem(song: widget.songs.elementAt(index), isLiked: false),
          );
        },
      ),
    );
  }
}