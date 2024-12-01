import 'package:flutter/material.dart';
import 'package:sound_sphere/core/controller/player_controller.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/track.dart';

class HistoryPlaylistPlayer extends StatelessWidget {
  const HistoryPlaylistPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(5),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: FakeData.obitoSongs.take(10).toList().length,
      itemBuilder: (context, index) {
        return HistoryPlayerSongItem(song: FakeData.obitoSongs[index]);
      },
    );
  }
}

class HistoryPlayerSongItem extends StatelessWidget {
  final Track song;
  const HistoryPlayerSongItem({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => PlayerController().setPlayerAudio([song]),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            song.imgURL,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          song.title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          song.artist,
          style: TextStyle(color: Colors.white),
        ),
        // trailing: IconButton(
        //   icon: Icon(Icons.more_vert),
        //   onPressed: () {},
        // ),
      ),
    );
  }
}
