import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/user_playlist.dart';

class AddToPlaylistSuccessDialog extends StatelessWidget {
  final UserPlaylist playlist;

  const AddToPlaylistSuccessDialog({Key? key, required this.playlist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            playlist.name!,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          // Text("Total Tracks: ${playlist.tracks.length}"),
          Text("Total Plays: ${playlist.totalPlay}"),
          Text("Total Duration: ${playlist.totalDuration} min"),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}
