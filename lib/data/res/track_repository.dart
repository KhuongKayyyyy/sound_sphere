import 'dart:convert';
import 'dart:io';

import 'package:sound_sphere/core/constant/api_config.dart';
import 'package:sound_sphere/data/models/track.dart';

class TrackRepository {
  static Future<List<Track>> fetchTrackWithPreview(
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
}
