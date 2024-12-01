class ApiConfig {
  static const String BASE_URL = 'http://127.0.0.1:8080/api/v1';
  static final int DEFAULT_LIMIT = 10;
}

class ArtistApi {
  // url
  static const String artists = '${ApiConfig.BASE_URL}/artists';
  static String artistById(String id) => '${ApiConfig.BASE_URL}/artists/$id';

  // selection
  static String nameAndAvatar = 'name avatar_url';
}

class AlbumApi {
  static const String albums = '${ApiConfig.BASE_URL}/albums/';
  static String albumById(String id) => '${ApiConfig.BASE_URL}/album/$id';
}

class TrackApi {
  static const String tracks = '${ApiConfig.BASE_URL}/tracks/';
  static String trackById(String id) => '${ApiConfig.BASE_URL}/tracks/$id';
  static String trackOfArtist(String artistId) =>
      '${ApiConfig.BASE_URL}/tracks/artist/$artistId';
  // selection
  static const String previewTrack = 'title image_url url_media creator';
  static const String fullTrack =
      'title genre release_date image_url url_media';
}
