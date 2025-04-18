import 'package:just_audio/just_audio.dart';
import 'package:sound_sphere/data/models/album.dart';
import 'package:sound_sphere/data/models/artist.dart';
import 'package:sound_sphere/data/models/genres.dart';

class Track {
  final String? id;
  final String title;
  final Artist artist;
  final List<Artist>? featuredArtists;
  final Album album;
  String duration;
  final String imgURL;
  final String lyrics;
  final String urlMedia;
  final List<String>? genre;
  final String? releaseDate;

  Track({
    this.id,
    required this.title,
    required this.artist,
    this.featuredArtists,
    this.genre,
    required this.album,
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
        artist = Artist.defaultArtist(),
        featuredArtists = [],
        genre = ['no genre'],
        album = Album.defaultAlbum(),
        duration = 'no duration',
        imgURL =
            'https://media.istockphoto.com/id/1147544807/vector/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=rnCKVbdxqkjlcs3xH87-9gocETqpspHFXu5dIGB4wuM=',
        lyrics = 'no lyrics',
        urlMedia = 'no media',
        releaseDate = 'no release date';

  factory Track.fromJson(Map<String, dynamic> json) {
    // Safely extracting the artist's name from the creator field
    String artistId = json['creator']?['_id'] ?? 'no artist id';
    String artistName = json['creator']?['name'] ?? 'no artist name';
    String artistAvatar = json['creator']?['avatar_url'] ?? 'no artist avatar';

    // Extracting the album information
    String albumId = json['album']?['_id'] ?? 'no album id';
    String albumTitle = json['album']?['title'] ?? 'no album title';

    List<String> genreList = (json['genre'] as List<dynamic>?)
            ?.map((item) => item.toString())
            .toList() ??
        [];

    List<Artist> collaborators = (json['collaborators'] as List<dynamic>?)
            ?.map((collaboratorJson) =>
                Artist.fromJson(collaboratorJson as Map<String, dynamic>))
            .toList() ??
        [];

    return Track(
      id: json['_id'] ?? 'no id',
      title: json['title'] ?? 'no title',
      imgURL: json['image_url'] ?? 'no image',
      artist: Artist(
          id: artistId,
          name: artistName,
          avatarURL: artistAvatar), // Use artist name from the 'creator' object
      genre: genreList,
      featuredArtists: collaborators,
      lyrics: json['lyric'] ?? 'no lyrics',
      urlMedia: json['url_media'] ?? 'no media',
      releaseDate: json['release_date'] ?? 'no release date',
      album: Album(
          id: albumId,
          title: albumTitle,
          aritst: Artist.defaultArtist(),
          genre: Genres(
              name: "Unknown Genre", imgURL: "https://via.placeholder.com/150"),
          tracks: [],
          imgURL: "",
          releaseDate: ""), // Adjust if needed to get this info
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
    return 'Track{id: $id, title: $title, artist: $artist, featuredArtists: $featuredArtists, albumName: $album, duration: $duration, imgURL: $imgURL, lyrics: $lyrics, urlMedia: $urlMedia, genre: $genre, releaseDate: $releaseDate}';
  }

  String getGenresAsString() {
    if (genre == null || genre!.isEmpty) {
      return 'no genre';
    }
    return genre!.map((g) => g[0].toUpperCase() + g.substring(1)).join(', ');
  }

  String getArtistsAsString() {
    if (featuredArtists == null || featuredArtists!.isEmpty) {
      return artist.name!;
    }
    String featuredArtistsNames =
        featuredArtists!.map((artist) => artist.name).skip(1).join(', ');
    return '${artist.name}, $featuredArtistsNames';
  }

  Future<void> fetchDuration() async {
    try {
      final player = AudioPlayer();
      await player.setUrl(urlMedia);
      final audioDuration = await player.load();
      if (audioDuration != null) {
        // Format duration as MM:SS
        duration = formatDurationAsText(audioDuration.inSeconds);
      } else {
        duration = 'Unknown duration';
      }
      await player.dispose(); // Dispose of the player after use
    } catch (e) {
      duration = 'Error fetching duration';
    }
  }

  String formatDurationAsText(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;

    String minuteText = minutes == 1 ? '1 minute' : '$minutes minutes';
    String secondText = seconds == 1 ? '1 second' : '$seconds seconds';

    if (minutes > 0 && seconds > 0) {
      return '$minuteText $secondText';
    } else if (minutes > 0) {
      return minuteText;
    } else {
      return secondText;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Track && runtimeType == other.runtimeType && id == other.id);

  @override
  int get hashCode => id.hashCode;
}
