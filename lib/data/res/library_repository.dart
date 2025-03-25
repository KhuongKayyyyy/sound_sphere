import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sound_sphere/core/constant/api_config.dart';
import 'package:sound_sphere/core/error/exceptions.dart';
import 'package:sound_sphere/data/models/track_in_library.dart';
import 'package:sound_sphere/data/models/user_library.dart';
import 'package:sound_sphere/data/res/user_repository.dart';

class LibraryRepository {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<UserLibrary> addTrackToLibrary(String trackId) async {
    try {
      String? token = await secureStorage.read(key: ApiConfig.token);
      var client = HttpClient();
      var request = await client
          .postUrl(Uri.parse(LibraryAPI.addTrackToLibrary(trackId)));
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
          final library = UserLibrary.fromJson(decodedJson['metadata']);
          return library;
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
          return await addTrackToLibrary(trackId);
        } catch (e) {
          throw AuthenticationException("Session expired, please log in again");
        }
      } else if (response.statusCode == HttpStatus.badRequest) {
        throw InvalidRequestException("Song already exists in the library");
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

  Future<List<TrackInLibrary>> getTrackLibrary(
      {required int page, required int limit}) async {
    try {
      String? token = await secureStorage.read(key: ApiConfig.token);
      var client = HttpClient();
      var request = await client.postUrl(Uri.parse(LibraryAPI.library));
      request.headers.set('content-type', 'application/json');
      request.headers.set('Authorization', 'Bearer $token');

      request.write(jsonEncode({'page': page, 'limit': limit}));

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
        if (decodedJson['metadata'] is List) {
          final List<dynamic> metadata = decodedJson['metadata'];
          final List<TrackInLibrary> tracks = metadata
              .map((trackJson) => TrackInLibrary.fromJson(trackJson))
              .toList();
          print("tracks: $tracks");
          return tracks;
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
          return await getTrackLibrary(page: page, limit: limit);
        } catch (e) {
          throw AuthenticationException("Session expired, please log in again");
        }
      } else if (response.statusCode == HttpStatus.badRequest) {
        throw InvalidRequestException("Song already exists in the library");
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

  Future<List<TrackInLibrary>> getFavoriteTracks(
      {int? page, int? limit}) async {
    try {
      String? token = await secureStorage.read(key: ApiConfig.token);
      var client = HttpClient();
      var request =
          await client.postUrl(Uri.parse(LibraryAPI.getFavoriteTracks));
      request.headers.set('content-type', 'application/json');
      request.headers.set('Authorization', 'Bearer $token');
      page ??= 1;
      limit ??= 100;
      request.write(jsonEncode({'page': page, 'limit': limit}));

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
        if (decodedJson['metadata'] is List) {
          if (decodedJson['metadata'] is List) {
            final List<dynamic> metadata = decodedJson['metadata'];
            final List<TrackInLibrary> tracks = metadata
                .map((trackJson) => TrackInLibrary.fromJson(trackJson))
                .toList();
            return tracks;
          }
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
          return await getFavoriteTracks();
        } catch (e) {
          throw AuthenticationException("Session expired, please log in again");
        }
      } else if (response.statusCode == HttpStatus.badRequest) {
        throw InvalidRequestException("Song already exists in the library");
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
    throw Exception("Unexpected error occurred");
  }

  Future<UserLibrary> removeTrackFromLibrary(String trackId) async {
    try {
      String? token = await secureStorage.read(key: ApiConfig.token);
      var client = HttpClient();
      var request = await client
          .patchUrl(Uri.parse(LibraryAPI.removeTrackFromLibrary(trackId)));
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
          final library = UserLibrary.fromJson(decodedJson['metadata']);
          return library;
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
          return await removeTrackFromLibrary(trackId);
        } catch (e) {
          throw AuthenticationException("Session expired, please log in again");
        }
      } else if (response.statusCode == HttpStatus.badRequest) {
        throw InvalidRequestException("Song already exists in the library");
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

  Future<bool> isTrackFavorite({required String trackId}) async {
    try {
      String? token = await secureStorage.read(key: ApiConfig.token);
      var client = HttpClient();
      var request =
          await client.getUrl(Uri.parse(LibraryAPI.isTrackFavorite(trackId)));
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
        if (decodedJson['metadata'] is bool) {
          return decodedJson['metadata'];
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
          return await isTrackFavorite(trackId: trackId);
        } catch (e) {
          throw AuthenticationException("Session expired, please log in again");
        }
      } else if (response.statusCode == HttpStatus.badRequest) {
        throw InvalidRequestException("Song already exists in the library");
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

  Future<UserLibrary> toggleFavoriteOfTrack(
      {required String trackId, required bool isFavorite}) async {
    try {
      String? token = await secureStorage.read(key: ApiConfig.token);
      var client = HttpClient();
      var request = await client
          .patchUrl(Uri.parse(LibraryAPI.toggleFavoriteTrack(trackId)));
      request.headers.set('content-type', 'application/json');
      request.headers.set('Authorization', 'Bearer $token');
      request.write(
        jsonEncode({"isFavourite": isFavorite.toString()}),
      );

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
          final library = UserLibrary.fromJson(decodedJson['metadata']);
          return library;
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
          return await toggleFavoriteOfTrack(
              trackId: trackId, isFavorite: isFavorite);
        } catch (e) {
          throw AuthenticationException("Session expired, please log in again");
        }
      } else if (response.statusCode == HttpStatus.badRequest) {
        return await addFavoriteTrack(trackId: trackId);
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

  Future<UserLibrary> addFavoriteTrack({required String trackId}) async {
    try {
      String? token = await secureStorage.read(key: ApiConfig.token);
      var client = HttpClient();
      var request = await client
          .postUrl(Uri.parse(LibraryAPI.addTrackToLibraryFavorite(trackId)));
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
          return UserLibrary.fromJson(decodedJson['metadata']);
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
          return await addFavoriteTrack(trackId: trackId);
        } catch (e) {
          throw AuthenticationException("Session expired, please log in again");
        }
      } else if (response.statusCode == HttpStatus.badRequest) {
        return await toggleFavoriteOfTrack(trackId: trackId, isFavorite: true);
      }

      throw AuthenticationException(
          "Failed to get user: ${response.statusCode}");
    } on AuthenticationException {
      rethrow;
    } on InvalidRequestException {
      rethrow;
    } catch (e) {
      throw Exception("Error during token refresh: $e");
    }
  }
}
