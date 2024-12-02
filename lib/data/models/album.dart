import 'track.dart';
import 'genres.dart'; // Assuming the Genres class is defined here

class Album {
  final String? id;
  final String title;
  final String aritst;
  final Genres genre;
  List<Track> tracks;
  final String imgURL;
  final String releaseDate;
  final String? type;

  Album({
    this.id,
    required this.title,
    required this.aritst,
    required this.genre,
    required this.tracks,
    required this.imgURL,
    required this.releaseDate,
    this.type,
  });
  @override
  String toString() {
    return 'Album{id: $id, title: $title, artist: $aritst, genre: ${genre.name}, songs: ${tracks.length}, imgURL: $imgURL, releaseDate: $releaseDate, type: $type}';
  }

  // Default constructor
  Album.defaultAlbum()
      : id = null,
        title = "Unknown Album",
        aritst = "Unknown Artist",
        genre = Genres(
            name: "Unknown Genre", imgURL: "https://via.placeholder.com/150"),
        tracks = [],
        imgURL = "https://via.placeholder.com/150",
        releaseDate = "Unknown Date",
        type = "Unknown Type";

  /// Method to calculate the total album duration in hours and minutes
  String getAlbumDuration() {
    int totalSeconds = 0;

    for (var song in tracks) {
      totalSeconds += _convertDurationToSeconds(song.duration);
    }

    return _formatDuration(totalSeconds);
  }

  /// Helper method to convert a duration string (e.g., "3:23") to seconds
  int _convertDurationToSeconds(String duration) {
    final parts = duration.split(':');
    if (parts.length == 2) {
      final minutes = int.tryParse(parts[0]) ?? 0;
      final seconds = int.tryParse(parts[1]) ?? 0;
      return (minutes * 60) + seconds;
    }
    return 0; // Return 0 if duration is in an unexpected format
  }

  /// Helper method to format total seconds into "X hour(s) Y minute(s)"
  String _formatDuration(int totalSeconds) {
    final hours = totalSeconds ~/ 3600; // Calculate hours
    final minutes = (totalSeconds % 3600) ~/ 60; // Calculate remaining minutes

    // Construct the duration string
    String durationString = '';
    if (hours > 0) {
      durationString += "$hours hour${hours > 1 ? 's' : ''} ";
    }
    if (minutes > 0 || hours == 0) {
      // Include minutes if there are any or if there are no hours
      durationString += "$minutes minute${minutes > 1 ? 's' : ''}";
    }
    return durationString.trim(); // Return the final formatted string
  }

  /// Factory constructor to create an Album instance from a JSON map
  factory Album.fromJson(Map<String, dynamic> json) {
    var creator = json['creator'] as Map<String, dynamic>?;

    return Album(
      id: json['_id'] ?? "id",
      title: json['title'] ?? "Unknown Album",
      aritst: creator?['name'] ?? "Unknown Artist",
      genre: (creator != null &&
              creator['genres'] is List &&
              (creator['genres'] as List).isNotEmpty)
          ? Genres(
              name: (creator['genres'] as List).first ?? "No Genre",
              imgURL: "temp", // Provide the correct image URL if available
            )
          : Genres(name: "No Genre", imgURL: "temp"),
      tracks: [], // Populate the list of songs if needed
      imgURL: json['image_url'] ?? "https://via.placeholder.com/150",
      releaseDate: json['release_date'] ?? "Unknown Date",
      type: json['type'] ?? "Unknown Type",
    );
  }

  /// Method to convert an Album instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': aritst,
      'genre': "",
      'songs': tracks.map((song) => song.toJson()).toList(),
      'imgURL': imgURL,
      'releaseDate': releaseDate,
    };
  }
}
