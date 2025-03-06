import 'package:sound_sphere/data/models/track.dart';

class Playlist {
  final String? id;
  final String? name;
  final String? imgURL;
  final List<Track>? tracks;

  Playlist({this.imgURL, this.id, this.name, this.tracks});
}
