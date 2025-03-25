import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/album.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/presentation/widgets/media/media_item.dart';

class AllSongGrid extends StatefulWidget {
  final List<Album>? albums;
  final List<Track>? songs;
  final String title;
  const AllSongGrid({super.key, this.songs, required this.title, this.albums});

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
      body: widget.albums != null
          ? Padding(
              padding: const EdgeInsets.only(left: 16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                ),
                itemCount: widget.albums?.length ?? 0,
                itemBuilder: (context, index) {
                  return MediaItem(
                    album: widget.albums!.elementAt(index),
                  );
                },
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                ),
                itemCount: widget.songs?.length ?? 0,
                itemBuilder: (context, index) {
                  return MediaItem(
                    track: widget.songs!.elementAt(index),
                  );
                },
              ),
            ),
    );
  }
}
