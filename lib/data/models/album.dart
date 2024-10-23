import 'song.dart';

class Album {
  final String title;
  final String artistName;
  final List<Song> songs;
  final String imgURL;
  final String releaseDate;

  Album({
    required this.title,
    required this.artistName,
    required this.songs,
    required this.imgURL,
    required this.releaseDate,
  });
}
