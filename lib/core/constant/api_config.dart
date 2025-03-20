class ApiConfig {
  // ignore: constant_identifier_names
  static const String BASE_URL = 'http://103.216.116.55:3002/api/v1';
  // ignore: non_constant_identifier_names
  static final int DEFAULT_LIMIT = 10;

  static const String token = 'token';
  static const String refreshToken = 'refresh_token';
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
  static const String trackLyric = "lyric";

  // library
  static const String addTrackToLibrary =
      '${ApiConfig.BASE_URL}/user-library/Track/';
  static String switchTrackFavorite(String trackId) =>
      '${ApiConfig.BASE_URL}/user-library/Track/$trackId/toggle-favorite';
}

class AuthenticationAPI {
  static const String login = '${ApiConfig.BASE_URL}/auth/login';
  static const String register = '${ApiConfig.BASE_URL}/auth/register';
  static const String logout = '${ApiConfig.BASE_URL}/auth/logout';
  static const String refreshToken = '${ApiConfig.BASE_URL}/auth/refresh-token';
}

class UserAPI {
  static const String getUserPrivate = '${ApiConfig.BASE_URL}/users/me';
  static String getUserPublicById(String id) =>
      '${ApiConfig.BASE_URL}/users/$id';
}

class PlaylistAPI {
  static const String playlist = '${ApiConfig.BASE_URL}/playlists/';
  static String getPlaylistById(String id) =>
      '${ApiConfig.BASE_URL}/playlists/$id';
  static const String addTrackToPlaylist =
      '${ApiConfig.BASE_URL}/playlists/add-track';
  static const String removeTrackFromPlaylist =
      '${ApiConfig.BASE_URL}/playlists/remove-track';
  static String switchToPublic(String playlistId) =>
      '${ApiConfig.BASE_URL}/playlists/$playlistId/public';
  static String switchToPrivate(String playlistId) =>
      '${ApiConfig.BASE_URL}/playlists/$playlistId/private';
  static String addAlbumToPlaylist =
      '${ApiConfig.BASE_URL}/playlists/add-tracks-from-album';
}
