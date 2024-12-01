class Track {
  final String title;
  final String artist;
  final String albumName;
  final String duration;
  final String imgURL;
  final String lyrics;
  final String urlMedia;

  Track({
    required this.title,
    required this.artist,
    required this.albumName,
    required this.duration,
    required this.imgURL,
    required this.lyrics,
    required this.urlMedia,
  });
  factory Track.fromJson(Map<String, dynamic> json) {
    // Safely extracting the artist's name from the creator field
    String artistString = json['creator']?['name'] ?? 'no artist';

    return Track(
      title: json['title'] ?? 'no title',
      imgURL: json['image_url'] ?? 'no image',
      artist: artistString, // Use artist name from the 'creator' object
      lyrics: json['lyric'] ?? 'no lyrics',
      urlMedia: json['url_media'] ?? 'no media',
      albumName: '', // Adjust if needed to get this info
      duration: '', // Adjust if needed to get this info
    );
  }

  // Method to convert Song object to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'cover_img': imgURL,
      'artist': artist,
      'lyric': lyrics,
      'url_media': urlMedia,
    };
  }
}
