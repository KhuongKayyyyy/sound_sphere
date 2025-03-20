import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sound_sphere/core/constant/api_config.dart';
import 'package:sound_sphere/core/error/exceptions.dart';
import 'package:sound_sphere/data/models/playlist.dart';
import 'package:sound_sphere/data/res/user_repository.dart';

class PlaylistRepository {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<List<Playlist>> getPlaylistOfUser() async {
    try {
      String? token = await secureStorage.read(key: ApiConfig.token);
      var client = HttpClient();
      var request = await client.getUrl(Uri.parse(PlaylistAPI.playlist));
      request.headers.set('content-type', 'application/json');
      request.headers.set('Authorization', 'Bearer $token');

      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();

      if (responseBody.isEmpty) {
        throw EmptyResponseException("Empty response from server");
      }

      Map<String, dynamic>? decodedJson;
      try {
        decodedJson = jsonDecode(responseBody);
      } catch (e) {
        throw InvalidJsonFormatException("Invalid JSON format: $e");
      }

      if (decodedJson == null || decodedJson.isEmpty) {
        throw EmptyResponseException("Response body is null or empty");
      }

      if (response.statusCode == HttpStatus.ok) {
        if (decodedJson['metadata'] is Map<String, dynamic> &&
            decodedJson['metadata']['data'] is List<dynamic>) {
          final playlists = (decodedJson['metadata']['data'] as List<dynamic>)
              .map((e) => Playlist.fromJson(e as Map<String, dynamic>))
              .toList();

          return playlists;
        } else {
          throw InvalidUserDataException("Invalid user data format");
        }
      } else if (response.statusCode == HttpStatus.unauthorized) {
        // Token expired, try refreshing it
        try {
          String? refreshToken =
              await secureStorage.read(key: ApiConfig.refreshToken);
          if (refreshToken == null) {
            throw AuthenticationException("Refresh token is null");
          }
          await UserRepository().refreshAccessToken();
          return await getPlaylistOfUser();
        } catch (e) {
          throw AuthenticationException("Session expired, please log in again");
        }
      } else {
        throw AuthenticationException(
            "Failed to get user: ${response.statusCode}");
      }
    } on AuthenticationException {
      rethrow;
    } catch (e) {
      throw Exception("Error during token refresh: $e");
    }
  }

  Future<Playlist> getPlaylistById({required String playlistId}) async {
    try {
      String? token = await secureStorage.read(key: ApiConfig.token);
      var client = HttpClient();
      var request = await client
          .getUrl(Uri.parse(PlaylistAPI.getPlaylistById(playlistId)));
      request.headers.set('content-type', 'application/json');
      request.headers.set('Authorization', 'Bearer $token');

      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();

      if (responseBody.isEmpty) {
        throw EmptyResponseException("Empty response from server");
      }

      Map<String, dynamic>? decodedJson;
      try {
        decodedJson = jsonDecode(responseBody);
      } catch (e) {
        throw InvalidJsonFormatException("Invalid JSON format: $e");
      }

      if (decodedJson == null || decodedJson.isEmpty) {
        throw EmptyResponseException("Response body is null or empty");
      }

      if (response.statusCode == HttpStatus.ok) {
        if (decodedJson['metadata'] is Map<String, dynamic>) {
          final playlist = Playlist.fromJson(decodedJson['metadata']);
          return playlist;
        } else {
          throw InvalidUserDataException("Invalid user data format");
        }
      } else if (response.statusCode == HttpStatus.unauthorized) {
        // Token expired, try refreshing it
        try {
          String? refreshToken =
              await secureStorage.read(key: ApiConfig.refreshToken);
          if (refreshToken == null) {
            throw AuthenticationException("Refresh token is null");
          }
          await UserRepository().refreshAccessToken();
          return await getPlaylistById(playlistId: playlistId);
        } catch (e) {
          throw AuthenticationException("Session expired, please log in again");
        }
      } else {
        throw AuthenticationException(
            "Failed to get user: ${response.statusCode}");
      }
    } on AuthenticationException {
      rethrow;
    } catch (e) {
      throw Exception("Error during token refresh: $e");
    }
  }

  Future<Playlist> addTrackToPlaylist(
      {required String playlistId, required String trackId}) async {
    try {
      String? token = await secureStorage.read(key: ApiConfig.token);
      var client = HttpClient();
      var request =
          await client.postUrl(Uri.parse(PlaylistAPI.addTrackToPlaylist));
      request.headers.set('content-type', 'application/json');
      request.headers.set('Authorization', 'Bearer $token');

      request.write(jsonEncode({
        'playlistId': playlistId,
        'trackId': trackId,
      }));

      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();

      if (responseBody.isEmpty) {
        throw EmptyResponseException("Empty response from server");
      }

      Map<String, dynamic>? decodedJson;
      try {
        decodedJson = jsonDecode(responseBody);
      } catch (e) {
        throw InvalidJsonFormatException("Invalid JSON format: $e");
      }

      if (decodedJson == null || decodedJson.isEmpty) {
        throw EmptyResponseException("Response body is null or empty");
      }

      if (response.statusCode == HttpStatus.ok) {
        if (decodedJson['metadata'] is Map<String, dynamic>) {
          final playlist = Playlist.fromJson(decodedJson['metadata']);
          return playlist;
        } else {
          throw InvalidUserDataException("Invalid user data format");
        }
      } else if (response.statusCode == HttpStatus.unauthorized) {
        // Token expired, try refreshing it
        try {
          String? refreshToken =
              await secureStorage.read(key: ApiConfig.refreshToken);
          if (refreshToken == null) {
            throw AuthenticationException("Refresh token is null");
          }
          await UserRepository().refreshAccessToken();
          return await addTrackToPlaylist(
              playlistId: playlistId, trackId: trackId);
        } catch (e) {
          throw AuthenticationException("Session expired, please log in again");
        }
      } else if (response.statusCode == HttpStatus.badRequest) {
        throw InvalidRequestException("Song already exists in the playlist");
      } else {
        throw AuthenticationException(
            "Failed to get user: ${response.statusCode}");
      }
    } on AuthenticationException {
      rethrow;
    } on InvalidRequestException {
      rethrow;
    } catch (e) {
      throw Exception("Error during token refresh: $e");
    }
  }

  Future<Playlist> removeTrackToPlaylist(
      {required String playlistId, required String trackId}) async {
    try {
      String? token = await secureStorage.read(key: ApiConfig.token);
      var client = HttpClient();
      var request =
          await client.postUrl(Uri.parse(PlaylistAPI.removeTrackFromPlaylist));
      request.headers.set('content-type', 'application/json');
      request.headers.set('Authorization', 'Bearer $token');

      request.write(jsonEncode({
        'playlistId': playlistId,
        'trackId': trackId,
      }));

      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();

      if (responseBody.isEmpty) {
        throw EmptyResponseException("Empty response from server");
      }

      Map<String, dynamic>? decodedJson;
      try {
        decodedJson = jsonDecode(responseBody);
      } catch (e) {
        throw InvalidJsonFormatException("Invalid JSON format: $e");
      }

      if (decodedJson == null || decodedJson.isEmpty) {
        throw EmptyResponseException("Response body is null or empty");
      }

      if (response.statusCode == HttpStatus.ok) {
        if (decodedJson['metadata'] is Map<String, dynamic>) {
          final playlist = Playlist.fromJson(decodedJson['metadata']);
          return playlist;
        } else {
          throw InvalidUserDataException("Invalid user data format");
        }
      } else if (response.statusCode == HttpStatus.unauthorized) {
        // Token expired, try refreshing it
        try {
          String? refreshToken =
              await secureStorage.read(key: ApiConfig.refreshToken);
          if (refreshToken == null) {
            throw AuthenticationException("Refresh token is null");
          }
          await UserRepository().refreshAccessToken();
          return await addTrackToPlaylist(
              playlistId: playlistId, trackId: trackId);
        } catch (e) {
          throw AuthenticationException("Session expired, please log in again");
        }
      } else if (response.statusCode == HttpStatus.badRequest) {
        throw InvalidRequestException("Song already exists in the playlist");
      } else {
        throw AuthenticationException(
            "Failed to get user: ${response.statusCode}");
      }
    } on AuthenticationException {
      rethrow;
    } on InvalidRequestException {
      rethrow;
    } catch (e) {
      throw Exception("Error during token refresh: $e");
    }
  }

  Future<Playlist> createNewPlaylist({required String playlistName}) async {
    {
      try {
        String? token = await secureStorage.read(key: ApiConfig.token);
        var client = HttpClient();
        var request = await client.postUrl(Uri.parse(PlaylistAPI.playlist));
        request.headers.set('content-type', 'application/json');
        request.headers.set('Authorization', 'Bearer $token');

        request.write(jsonEncode({
          'title': playlistName,
        }));

        var response = await request.close();
        var responseBody = await response.transform(utf8.decoder).join();

        if (responseBody.isEmpty) {
          throw EmptyResponseException("Empty response from server");
        }

        Map<String, dynamic>? decodedJson;
        try {
          decodedJson = jsonDecode(responseBody);
        } catch (e) {
          throw InvalidJsonFormatException("Invalid JSON format: $e");
        }

        if (decodedJson == null || decodedJson.isEmpty) {
          throw EmptyResponseException("Response body is null or empty");
        }

        if (response.statusCode == HttpStatus.ok) {
          if (decodedJson['metadata'] is Map<String, dynamic>) {
            final playlist = Playlist.fromJson(decodedJson['metadata']);
            return playlist;
          } else {
            throw InvalidUserDataException("Invalid user data format");
          }
        } else if (response.statusCode == HttpStatus.unauthorized) {
          // Token expired, try refreshing it
          try {
            String? refreshToken =
                await secureStorage.read(key: ApiConfig.refreshToken);
            if (refreshToken == null) {
              throw AuthenticationException("Refresh token is null");
            }
            await UserRepository().refreshAccessToken();
            return await createNewPlaylist(playlistName: playlistName);
          } catch (e) {
            throw AuthenticationException(
                "Session expired, please log in again");
          }
        } else {
          throw AuthenticationException(
              "Failed to get user: ${response.statusCode}");
        }
      } on AuthenticationException {
        rethrow;
      } catch (e) {
        throw Exception("Error during token refresh: $e");
      }
    }
  }

  Future<Playlist> switchToPublic({required String playlistID}) async {
    try {
      String? token = await secureStorage.read(key: ApiConfig.token);
      var client = HttpClient();
      var request = await client
          .patchUrl(Uri.parse(PlaylistAPI.switchToPublic(playlistID)));
      request.headers.set('content-type', 'application/json');
      request.headers.set('Authorization', 'Bearer $token');

      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();

      if (responseBody.isEmpty) {
        throw EmptyResponseException("Empty response from server");
      }

      Map<String, dynamic>? decodedJson;
      try {
        decodedJson = jsonDecode(responseBody);
      } catch (e) {
        throw InvalidJsonFormatException("Invalid JSON format: $e");
      }

      if (decodedJson == null || decodedJson.isEmpty) {
        throw EmptyResponseException("Response body is null or empty");
      }

      if (response.statusCode == HttpStatus.ok) {
        if (decodedJson['metadata'] is Map<String, dynamic>) {
          final playlist = Playlist.fromJson(decodedJson['metadata']);
          return playlist;
        } else {
          throw InvalidUserDataException("Invalid user data format");
        }
      } else if (response.statusCode == HttpStatus.unauthorized) {
        // Token expired, try refreshing it
        try {
          String? refreshToken =
              await secureStorage.read(key: ApiConfig.refreshToken);
          if (refreshToken == null) {
            throw AuthenticationException("Refresh token is null");
          }
          await UserRepository().refreshAccessToken();
          return await switchToPublic(playlistID: playlistID);
        } catch (e) {
          throw AuthenticationException("Session expired, please log in again");
        }
      } else {
        throw AuthenticationException(
            "Failed to get user: ${response.statusCode}");
      }
    } on AuthenticationException {
      rethrow;
    } catch (e) {
      throw Exception("Error during token refresh: $e");
    }
  }

  Future<Playlist> switchToPrivate({required String playlistID}) async {
    try {
      String? token = await secureStorage.read(key: ApiConfig.token);
      var client = HttpClient();
      var request = await client
          .patchUrl(Uri.parse(PlaylistAPI.switchToPrivate(playlistID)));
      request.headers.set('content-type', 'application/json');
      request.headers.set('Authorization', 'Bearer $token');

      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();

      if (responseBody.isEmpty) {
        throw EmptyResponseException("Empty response from server");
      }

      Map<String, dynamic>? decodedJson;
      try {
        decodedJson = jsonDecode(responseBody);
      } catch (e) {
        throw InvalidJsonFormatException("Invalid JSON format: $e");
      }

      if (decodedJson == null || decodedJson.isEmpty) {
        throw EmptyResponseException("Response body is null or empty");
      }

      if (response.statusCode == HttpStatus.ok) {
        if (decodedJson['metadata'] is Map<String, dynamic>) {
          final playlist = Playlist.fromJson(decodedJson['metadata']);
          return playlist;
        } else {
          throw InvalidUserDataException("Invalid user data format");
        }
      } else if (response.statusCode == HttpStatus.unauthorized) {
        // Token expired, try refreshing it
        try {
          String? refreshToken =
              await secureStorage.read(key: ApiConfig.refreshToken);
          if (refreshToken == null) {
            throw AuthenticationException("Refresh token is null");
          }
          await UserRepository().refreshAccessToken();
          return await switchToPublic(playlistID: playlistID);
        } catch (e) {
          throw AuthenticationException("Session expired, please log in again");
        }
      } else {
        throw AuthenticationException(
            "Failed to get user: ${response.statusCode}");
      }
    } on AuthenticationException {
      rethrow;
    } catch (e) {
      throw Exception("Error during token refresh: $e");
    }
  }

  Future<Playlist> addAlbumToPlayList(
      {required String playlistId, required String albumId}) async {
    try {
      String? token = await secureStorage.read(key: ApiConfig.token);
      var client = HttpClient();
      var request =
          await client.postUrl(Uri.parse(PlaylistAPI.addAlbumToPlaylist));
      request.headers.set('content-type', 'application/json');
      request.headers.set('Authorization', 'Bearer $token');

      request.write(jsonEncode({
        "playlistId": playlistId,
        "albumId": albumId,
      }));

      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();

      if (responseBody.isEmpty) {
        throw EmptyResponseException("Empty response from server");
      }

      Map<String, dynamic>? decodedJson;
      try {
        decodedJson = jsonDecode(responseBody);
      } catch (e) {
        throw InvalidJsonFormatException("Invalid JSON format: $e");
      }

      if (decodedJson == null || decodedJson.isEmpty) {
        throw EmptyResponseException("Response body is null or empty");
      }

      if (response.statusCode == HttpStatus.ok) {
        if (decodedJson['metadata'] is Map<String, dynamic>) {
          final playlist = Playlist.fromJson(decodedJson['metadata']);
          return playlist;
        } else {
          throw InvalidUserDataException("Invalid user data format");
        }
      } else if (response.statusCode == HttpStatus.unauthorized) {
        // Token expired, try refreshing it
        try {
          String? refreshToken =
              await secureStorage.read(key: ApiConfig.refreshToken);
          if (refreshToken == null) {
            throw AuthenticationException("Refresh token is null");
          }
          await UserRepository().refreshAccessToken();
          return await addAlbumToPlayList(
              playlistId: playlistId, albumId: albumId);
        } catch (e) {
          throw AuthenticationException("Session expired, please log in again");
        }
      } else if (response.statusCode == HttpStatus.badRequest) {
        throw InvalidRequestException("Song already exists in the playlist");
      } else {
        throw AuthenticationException(
            "Failed to get user: ${response.statusCode}");
      }
    } on AuthenticationException {
      rethrow;
    } on InvalidRequestException {
      rethrow;
    } catch (e) {
      throw Exception("Error during token refresh: $e");
    }
  }

  Future<Playlist> deletePlaylist({required String playlistId}) async {
    try {
      String? token = await secureStorage.read(key: ApiConfig.token);
      var client = HttpClient();
      var request = await client
          .deleteUrl(Uri.parse(PlaylistAPI.getPlaylistById(playlistId)));
      request.headers.set('content-type', 'application/json');
      request.headers.set('Authorization', 'Bearer $token');

      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();

      if (responseBody.isEmpty) {
        throw EmptyResponseException("Empty response from server");
      }

      Map<String, dynamic>? decodedJson;
      try {
        decodedJson = jsonDecode(responseBody);
      } catch (e) {
        throw InvalidJsonFormatException("Invalid JSON format: $e");
      }

      if (decodedJson == null || decodedJson.isEmpty) {
        throw EmptyResponseException("Response body is null or empty");
      }

      if (response.statusCode == HttpStatus.ok) {
        if (decodedJson['metadata'] is Map<String, dynamic>) {
          final playlist = Playlist.fromJson(decodedJson['metadata']);
          return playlist;
        } else {
          throw InvalidUserDataException("Invalid user data format");
        }
      } else if (response.statusCode == HttpStatus.unauthorized) {
        // Token expired, try refreshing it
        try {
          String? refreshToken =
              await secureStorage.read(key: ApiConfig.refreshToken);
          if (refreshToken == null) {
            throw AuthenticationException("Refresh token is null");
          }
          await UserRepository().refreshAccessToken();
          return await deletePlaylist(playlistId: playlistId);
        } catch (e) {
          throw AuthenticationException("Session expired, please log in again");
        }
      } else if (response.statusCode == HttpStatus.badRequest) {
        throw InvalidRequestException("Song already exists in the playlist");
      } else {
        throw AuthenticationException(
            "Failed to get user: ${response.statusCode}");
      }
    } on AuthenticationException {
      rethrow;
    } on InvalidRequestException {
      rethrow;
    } catch (e) {
      throw Exception("Error during token refresh: $e");
    }
  }
}
