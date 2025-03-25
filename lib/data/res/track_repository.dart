import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:sound_sphere/core/constant/api_config.dart';
import 'package:sound_sphere/data/models/track.dart';

class TrackRepository {
  static Future<List<Track>> getTracksWithPreview(
      int page, int limit, String select) async {
    var client = HttpClient();
    List<Track> tracks = [];
    try {
      // Encode query parameters
      var url = Uri.parse(TrackApi.tracks);
      var request = await client.postUrl(url);

      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
      request.write(jsonEncode({
        'page': page,
        'limit': limit,
        'select': select,
        "isPopulateCreator": true
      }));

      var response = await request.close();

      if (response.statusCode == HttpStatus.created) {
        var responseBody = await response.transform(utf8.decoder).join();
        var decodedJson = jsonDecode(responseBody);
        if (decodedJson is Map<String, dynamic> &&
            decodedJson['metadata'] is Map<String, dynamic> &&
            decodedJson['metadata']['data'] is List) {
          List result = decodedJson['metadata']['data'];
          for (var i = 0; i < result.length; i++) {
            tracks.add(Track.fromJson(result[i] as Map<String, dynamic>));
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      client.close();
    }
    return tracks;
  }

  static Future<Track> getTrackDetailById(String id, String select) async {
    var client = HttpClient();
    Track track = Track.defaultTrack();
    try {
      var url = Uri.parse(TrackApi.trackById(id));
      var request = await client.postUrl(url);

      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
      request.write(jsonEncode({
        "select": select,
        "isPopulateAlbum": true,
        "isPopulateCreator": true,
        "isPopulateCollaborators": true
      }));
      var response = await request.close();
      if (response.statusCode == HttpStatus.created) {
        var responseBody = await response.transform(utf8.decoder).join();
        var decodedJson = jsonDecode(responseBody)['metadata'];
        if (decodedJson is Map<String, dynamic>) {
          track = Track.fromJson(decodedJson);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      client.close();
    }
    return track;
  }

  static Future<List<Track>> getTracksOfArtist(String artistId) async {
    var client = HttpClient();
    List<Track> tracks = [];
    try {
      // Encode query parameters
      var url = Uri.parse(TrackApi.trackOfArtist(artistId));
      var request = await client.postUrl(url);

      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
      request.write(jsonEncode({
        "select": TrackApi.previewTrack,
        "isPopulateCreator": true,
        "isPopulateCollaborators": true
      }));

      var response = await request.close();

      if (response.statusCode == HttpStatus.created) {
        var responseBody = await response.transform(utf8.decoder).join();
        var decodedJson = jsonDecode(responseBody);

        if (decodedJson is Map<String, dynamic> &&
            decodedJson['metadata'] is List) {
          List metadata = decodedJson['metadata'];

          for (var trackJson in metadata) {
            tracks.add(Track.fromJson(trackJson as Map<String, dynamic>));
          }
        } else {
          if (kDebugMode) {
            print('Unexpected response format: $decodedJson');
          }
        }
      } else {
        if (kDebugMode) {
          print('Failed to fetch data. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      client.close();
    }
    return tracks;
  }

  static Future<List<Track>> getTracksOfAlbum(String albumId) async {
    var client = HttpClient();
    List<Track> tracks = [];
    try {
      // Encode query parameters
      var url = Uri.parse(TrackApi.trackOfAlbum(albumId));
      var request = await client.postUrl(url);

      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
      request.write(jsonEncode({
        "select": TrackApi.previewTrack,
        "isPopulateCreator": true,
        "isPopulateCollaborators": true,
        "album": albumId
      }));

      var response = await request.close();

      if (response.statusCode == HttpStatus.created) {
        var responseBody = await response.transform(utf8.decoder).join();
        var decodedJson = jsonDecode(responseBody);

        if (decodedJson is Map<String, dynamic> &&
            decodedJson['metadata']['data'] is List) {
          List metadata = decodedJson['metadata']['data'];

          for (var trackJson in metadata) {
            tracks.add(Track.fromJson(trackJson as Map<String, dynamic>));
          }
        } else {
          log('Unexpected response format: $decodedJson' as num);
        }
      } else {
        if (kDebugMode) {
          print('Failed to fetch data. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      client.close();
    }
    return tracks;
  }

  static Future<List<Track>> getTopTracksOfArtist(
      {required String artistId, int? page, int? limit}) async {
    var client = HttpClient();
    List<Track> tracks = [];
    try {
      // Encode query parameters
      var url = Uri.parse(TrackApi.topTrackOfArtist(artistId));
      var request = await client.postUrl(url);

      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
      Map<String, dynamic> requestBody = {
        "select": TrackApi.previewTrack,
        "isPopulateCreator": true,
        "isPopulateCollaborators": true
      };
      if (page != null) requestBody["page"] = page;
      if (limit != null) requestBody["limit"] = limit;

      request.write(jsonEncode(requestBody));

      var response = await request.close();

      if (response.statusCode == HttpStatus.created) {
        var responseBody = await response.transform(utf8.decoder).join();
        var decodedJson = jsonDecode(responseBody);

        if (decodedJson is Map<String, dynamic> &&
            decodedJson['metadata']['data'] is List) {
          List metadata = decodedJson['metadata']['data'];

          for (var trackJson in metadata) {
            tracks.add(Track.fromJson(trackJson as Map<String, dynamic>));
          }
        } else {
          if (kDebugMode) {
            print('Unexpected response format: $decodedJson');
          }
        }
      } else {
        if (kDebugMode) {
          print('Failed to fetch data. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      client.close();
    }
    return tracks;
  }

  static Future<List<Track>> getTrackByGenre(String genre) async {
    var client = HttpClient();
    List<Track> tracks = [];
    try {
      // Encode query parameters
      var url = Uri.parse(TrackApi.tracks);
      var request = await client.postUrl(url);

      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
      request.write(jsonEncode({
        "select": TrackApi.previewTrack,
        "isPopulateCreator": true,
        "isPopulateCollaborators": true,
        "genre": genre
      }));

      var response = await request.close();

      if (response.statusCode == HttpStatus.created) {
        var responseBody = await response.transform(utf8.decoder).join();
        var decodedJson = jsonDecode(responseBody);

        if (decodedJson is Map<String, dynamic> &&
            decodedJson['metadata']['data'] is List) {
          List metadata = decodedJson['metadata']['data'];

          for (var trackJson in metadata) {
            tracks.add(Track.fromJson(trackJson as Map<String, dynamic>));
          }
        } else {
          if (kDebugMode) {
            print('Unexpected response format: $decodedJson');
          }
        }
      } else {
        if (kDebugMode) {
          print('Failed to fetch data. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      client.close();
    }
    return tracks;
  }

  static Future<String> getTrackLyric(String trackId) async {
    var client = HttpClient();
    String lyric = '';

    try {
      var url = Uri.parse(TrackApi.trackById(trackId));
      var request = await client.postUrl(url);

      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
      request.write(jsonEncode({
        "select": TrackApi.trackLyric,
      }));

      var response = await request.close();

      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.created) {
        var responseBody = await response.transform(utf8.decoder).join();
        var decodedJson = jsonDecode(responseBody);

        if (decodedJson is Map<String, dynamic> &&
            decodedJson['metadata'] is Map<String, dynamic>) {
          var metadata = decodedJson['metadata'];
          lyric = metadata['lyric'] ?? 'No lyric available';
        } else {
          if (kDebugMode) {
            print('Unexpected response format: $decodedJson');
          }
        }
      } else {
        if (kDebugMode) {
          print('Failed to fetch data. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      client.close();
    }
    return lyric;
  }

  static Future<List<Track>> getTopTrackByPlay() async {
    var client = HttpClient();
    List<Track> tracks = [];
    try {
      // Encode query parameters
      var url = Uri.parse(TrackApi.tracks);
      var request = await client.postUrl(url);

      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
      request.write(jsonEncode({
        "select": TrackApi.previewTrack,
        "isPopulateCreator": true,
        "isPopulateCollaborators": true,
        "sort": "-total_play",
        "limit": 50
      }));

      var response = await request.close();

      if (response.statusCode == HttpStatus.created) {
        var responseBody = await response.transform(utf8.decoder).join();
        var decodedJson = jsonDecode(responseBody);

        if (decodedJson is Map<String, dynamic> &&
            decodedJson['metadata']['data'] is List) {
          List metadata = decodedJson['metadata']['data'];

          for (var trackJson in metadata) {
            tracks.add(Track.fromJson(trackJson as Map<String, dynamic>));
          }
        } else {
          if (kDebugMode) {
            print('Unexpected response format: $decodedJson');
          }
        }
      } else {
        if (kDebugMode) {
          print('Failed to fetch data. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      client.close();
    }
    if (kDebugMode) {
      print(tracks.length);
    }
    return tracks;
  }

  static Future<List<Track>> getFeaturedTrack(
      {required String artistId}) async {
    var client = HttpClient();
    List<Track> tracks = [];
    try {
      // Encode query parameters
      var url = Uri.parse(TrackApi.featuredTrackByArtist(artistId));
      var request = await client.postUrl(url);

      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
      request.write(jsonEncode({
        "select": "title image_url url_media total_play",
        "isPopulateCreator": true,
        "isPopulateCollaborators": true
      }));

      var response = await request.close();

      if (response.statusCode == HttpStatus.created) {
        var responseBody = await response.transform(utf8.decoder).join();
        var decodedJson = jsonDecode(responseBody);

        if (decodedJson is Map<String, dynamic> &&
            decodedJson['metadata']['data'] is List) {
          List metadata = decodedJson['metadata']['data'];

          for (var trackJson in metadata) {
            tracks.add(Track.fromJson(trackJson as Map<String, dynamic>));
          }
        } else {
          if (kDebugMode) {
            print('Unexpected response format: $decodedJson');
          }
        }
      } else {
        if (kDebugMode) {
          print('Failed to fetch data. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      client.close();
    }
    if (kDebugMode) {
      print(tracks.length);
    }
    print(tracks);
    return tracks;
  }
}
