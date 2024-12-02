class ApiConfig {
  // ignore: constant_identifier_names
  static const String BASE_URL = 'http://127.0.0.1:8080/api/v1';
  // ignore: non_constant_identifier_names
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
  static String albumByArtistId(String id) =>
      '${ApiConfig.BASE_URL}/albums/artist/$id';
  static String albumById(String id) => '${ApiConfig.BASE_URL}/albums/$id';

  static String latestAlbumByArtistId(String id) =>
      '${ApiConfig.BASE_URL}/albums/latest/artist/$id';

  // selection

  static const String previewAlbum =
      'title image_url creator type release_date';
}

class TrackApi {
  static const String tracks = '${ApiConfig.BASE_URL}/tracks/';
  static String trackById(String id) => '${ApiConfig.BASE_URL}/tracks/$id';
  static String trackOfArtist(String artistId) =>
      '${ApiConfig.BASE_URL}/tracks/artist/$artistId';
  static String trackOfAlbum(String albumId) =>
      '${ApiConfig.BASE_URL}/tracks/album/$albumId';
  static String topTrackOfArtist(String artistId) =>
      '${ApiConfig.BASE_URL}/tracks/top/artist/$artistId';
  // selection
  static const String previewTrack = 'title image_url url_media creator';
  static const String fullTrack =
      'title genre release_date image_url url_media';
}
