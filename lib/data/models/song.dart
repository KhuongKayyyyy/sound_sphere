class Song {
  final String title;
  final String artistName;
  final String albumName;
  final String duration;
  final String imgURL;
  final String lyrics;
  final String urlMedia;

  Song({
    required this.title,
    required this.artistName,
    required this.albumName,
    required this.duration,
    required this.imgURL,
    required this.lyrics,
    required this.urlMedia,
  });
  factory Song.fromJson(Map<String, dynamic> json) {
    String artistString = (json['artist'] as List<dynamic>).join(' & ');

    return Song(
      title: json['title'] as String,
      imgURL: json['cover_img'] as String,
      artistName: artistString,
      lyrics: json['lyric'] as String,
      urlMedia: json['url_media'] as String,
      albumName: '',
      duration: '',
    );
  }

  // Method to convert Song object to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'cover_img': imgURL,
      'artist': artistName,
      'lyric': lyrics,
      'url_media': urlMedia,
    };
  }
}
