class Track {
  final String? id;
  final String title;
  final String artist;
  final String albumName;
  final String duration;
  final String imgURL;
  final String lyrics;
  final String urlMedia;
  final List<String>? genre;
  final String? releaseDate;

  Track({
    this.id,
    required this.title,
    required this.artist,
    this.genre,
    required this.albumName,
    required this.duration,
    required this.imgURL,
    required this.lyrics,
    required this.urlMedia,
    this.releaseDate,
  });

  // Default constructor
  Track.defaultTrack()
      : id = 'no id',
        title = 'no title',
        artist = 'no artist',
        genre = ['no genre'],
        albumName = 'no album',
        duration = 'no duration',
        imgURL = 'no image',
        lyrics = 'no lyrics',
        urlMedia = 'no media',
        releaseDate = 'no release date';

  factory Track.fromJson(Map<String, dynamic> json) {
    // Safely extracting the artist's name from the creator field
    String artistString = json['creator']?['_id'] ?? 'no artist';
    List<String> genreList = (json['genre'] as List<dynamic>?)
            ?.map((item) => item.toString())
            .toList() ??
        ['no genre'];

    return Track(
      id: json['_id'] ?? 'no id',
      title: json['title'] ?? 'no title',
      imgURL: json['image_url'] ?? 'no image',
      artist: artistString, // Use artist name from the 'creator' object
      genre: genreList,
      lyrics: json['lyric'] ?? 'no lyrics',
      urlMedia: json['url_media'] ?? 'no media',
      releaseDate: json['release_date'] ?? 'no release date',
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

  @override
  String toString() {
    return 'Track{title: $title, artist: $artist, albumName: $albumName, duration: $duration, imgURL: $imgURL, lyrics: $lyrics, urlMedia: $urlMedia}';
  }

  String getGenresAsString() {
    if (genre == null || genre!.isEmpty) {
      return 'no genre';
    }
    return genre!.map((g) => g[0].toUpperCase() + g.substring(1)).join(', ');
  }
}
