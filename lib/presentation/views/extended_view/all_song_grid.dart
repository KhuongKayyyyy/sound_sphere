import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/song.dart';
import 'package:sound_sphere/presentation/widgets/song/song_item.dart';

class AllSongGrid extends StatefulWidget {
  final List<Song> songs;
  final String title;
  const AllSongGrid({super.key, required this.songs, required this.title});

  @override
  State<AllSongGrid> createState() => _AllSongGridState();
}

class _AllSongGridState extends State<AllSongGrid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black)),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.95,
        ),
        itemCount: widget.songs.length,
        itemBuilder: (context, index) {
          return SongItem(
            song: widget.songs.elementAt(index),
          );
        },
      ),
    );
  }
}
