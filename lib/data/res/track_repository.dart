import 'dart:convert';
import 'dart:io';

import 'package:sound_sphere/core/constant/api_config.dart';
import 'package:sound_sphere/data/models/track.dart';

class TrackRepository {
  static Future<List<Track>> getTrackWithPreview(
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
      print('Error: $e');
    } finally {
      client.close();
    }
    return tracks;
  }

  static Future<Track> getTrackById(String id) async {
    var client = HttpClient();
    Track track = Track.defaultTrack();
    try {
      var url = Uri.parse(TrackApi.trackById(id));
      var request = await client.postUrl(url);

      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
      request.write(jsonEncode({
        "select": TrackApi.fullTrack,
        "isPopulateCreator": true,
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
      print('Error: $e');
    } finally {
      client.close();
    }
    return track;
  }

  static Future<List<Track>> getTrackOfArtist(String artistId) async {
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
          print('Unexpected response format: $decodedJson');
        }
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      client.close();
    }
    return tracks;
  }
}
