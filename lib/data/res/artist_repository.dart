import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sound_sphere/core/constant/api_config.dart';
import 'package:sound_sphere/data/models/artist.dart';

class ArtistRepository {
  static Future<List<Artist>> getArtists(
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

  static Future<String> getArtistName(String id) async {
    var client = HttpClient();
    String artistName = '';
    try {
      var request = await client.postUrl(Uri.parse(ArtistApi.artistById(id)));
      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
      request.write(jsonEncode({
        "select": "name",
      }));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var responseBody = await response.transform(utf8.decoder).join();
        var decodedJson = jsonDecode(responseBody);
        if (decodedJson is Map<String, dynamic> &&
            decodedJson['metadata'] is Map<String, dynamic>) {
          artistName = decodedJson['metadata']['name'];
        }
      }
    } catch (e) {
      log(e.toString());
    } finally {
      client.close();
    }
    return artistName;
  }

  static Future<Artist> getArtistById(String id) async {
    var client = HttpClient();
    Artist artist = Artist.defaultArtist();
    try {
      var request = await client.postUrl(Uri.parse(ArtistApi.artistById(id)));
      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
      request.write(jsonEncode({
        "select": ArtistApi.nameAndAvatar,
      }));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var responseBody = await response.transform(utf8.decoder).join();
        var decodedJson = jsonDecode(responseBody);
        if (decodedJson is Map<String, dynamic> &&
            decodedJson['metadata'] is Map<String, dynamic>) {
          artist = Artist.fromJson(decodedJson['metadata']);
        }
      }
    } catch (e) {
      log(e.toString());
    } finally {
      client.close();
    }
    if (kDebugMode) {
      print(artist.name);
    }
    return artist;
  }
}
