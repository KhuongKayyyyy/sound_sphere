import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:sound_sphere/core/constant/api_config.dart';
import 'package:sound_sphere/data/models/artist.dart';

class ArtistRepository {
  static Future<List<Artist>> fetchArtists(
      int page, int limit, String select) async {
    var client = HttpClient();
    List<Artist> artists = [];
    try {
      var request = await client.postUrl(Uri.parse(ArtistApi.artists));
      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
      request.write(jsonEncode({
        "page": page,
        "limit": limit,
        "sort": "name",
        "select": select,
      }));
      var response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        var responseBody = await response.transform(utf8.decoder).join();
        var decodedJson = jsonDecode(responseBody);

        if (decodedJson is Map<String, dynamic> &&
            decodedJson['metadata'] is Map<String, dynamic> &&
            decodedJson['metadata']['data'] is List) {
          List result = decodedJson['metadata']['data'];
          for (var item in result) {
            artists.add(Artist.fromJson(item as Map<String, dynamic>));
          }
        }
      }
    } catch (e) {
      log(e.toString());
    } finally {
      client.close();
    }
    return artists;
  }
}
