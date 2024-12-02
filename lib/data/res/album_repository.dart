import 'dart:convert';
import 'dart:io';

import 'package:sound_sphere/core/constant/api_config.dart';
import 'package:sound_sphere/core/utils/logger.dart';
import 'package:sound_sphere/data/models/album.dart';

class AlbumRepository {
  static Future<List<Album>> fetchAlbumWithPreviewInformation(int page) async {
    var client = HttpClient();
    List<Album> albums = [];
    try {
      // Encode query parameters
      var url = Uri.parse(AlbumApi.albums);
      var request = await client.postUrl(url);

      // Add headers and body
      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
      request.write(jsonEncode({
        'page': page,
        'limit': ApiConfig.DEFAULT_LIMIT,
        // 'sort': 'title',
        "select": "title creator image_url type",
        'isPopulateCreator': true
      }));

      var response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        var responseBody = await response.transform(utf8.decoder).join();
        var decodedJson = jsonDecode(responseBody);

        if (decodedJson is Map<String, dynamic> &&
            decodedJson['metadata'] is Map<String, dynamic> &&
            decodedJson['metadata']['data'] is List) {
          List result = decodedJson['metadata']['data'];
          for (var i = 0; i < result.length; i++) {
            albums.add(Album.fromJson(result[i] as Map<String, dynamic>));
          }
        }
      }
    } catch (e) {
      Logger.Red.log('Error: $e');
    } finally {
      client.close();
    }
    return albums;
  }

  static Future<List<Album>> getAlbumOfArtist(String id) async {
    var client = HttpClient();
    List<Album> albums = [];
    try {
      // Encode query parameters
      var url = Uri.parse(AlbumApi.albumByArtistId(id));
      var request = await client.postUrl(url);

      // Add headers and body
      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
      request.write(jsonEncode({
        "select": "title creator image_url type",
        "isPopulateCreator": true
      }));

      var response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        var responseBody = await response.transform(utf8.decoder).join();
        var decodedJson = jsonDecode(responseBody);

        if (decodedJson is Map<String, dynamic> &&
            decodedJson['metadata'] is Map<String, dynamic> &&
            decodedJson['metadata']['data'] is List) {
          List result = decodedJson['metadata']['data'];
          for (var i = 0; i < result.length; i++) {
            albums.add(Album.fromJson(result[i] as Map<String, dynamic>));
          }
        }
      }
    } catch (e) {
      Logger.Red.log('Error: $e');
    } finally {
      client.close();
    }
    print(albums.length);
    return albums;
  }

  static Future<Album> getAlbumDetailById(String id) async {
    var client = HttpClient();
    Album album = Album.defaultAlbum();
    try {
      var url = Uri.parse(AlbumApi.albumById(id));
      var request = await client.postUrl(url);

      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
      request.write(jsonEncode({"isPopulateCreator": true}));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var responseBody = await response.transform(utf8.decoder).join();
        var decodedJson = jsonDecode(responseBody)['metadata'];
        if (decodedJson is Map<String, dynamic>) {
          album = Album.fromJson(decodedJson);
        }
      }
    } catch (e) {
      Logger.Red.log('Error: $e');
    } finally {
      client.close();
    }
    return album;
  }

  static Future<Album> getLatestAlbumByArtistId(String id) async {
    var client = HttpClient();
    Album album = Album.defaultAlbum();
    try {
      var url = Uri.parse(AlbumApi.latestAlbumByArtistId(id));
      var request = await client.postUrl(url);

      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
      request.write(jsonEncode(
          {"select": AlbumApi.previewAlbum, 'isPopulateCreator': true}));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var responseBody = await response.transform(utf8.decoder).join();
        // print(responseBody);
        var decodedJson = jsonDecode(responseBody)['metadata'];
        print(decodedJson);
        if (decodedJson is Map<String, dynamic>) {
          album = Album.fromJson(decodedJson);
        }
      }
    } catch (e) {
      Logger.Red.log('Error: $e');
    } finally {
      client.close();
    }
    return album;
  }
}
