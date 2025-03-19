import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sound_sphere/core/constant/api_config.dart';
import 'package:sound_sphere/core/error/exceptions.dart';
import 'package:sound_sphere/data/models/app_user.dart';

class UserRepository {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  Future<AppUser> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      var client = HttpClient();
      var request = await client.postUrl(Uri.parse(AuthenticationAPI.register));
      request.headers.set('content-type', 'application/json');
      request.write(jsonEncode({
        "email": email,
        "password": password,
        "display_name": name,
        "country": "VietNam",
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

      // Handle different status codes
      if (response.statusCode == HttpStatus.created) {
        if (decodedJson['metadata'] is Map<String, dynamic>) {
          return AppUser.fromJson(decodedJson['metadata']);
        } else {
          throw InvalidUserDataException("Invalid user data format");
        }
      } else if (response.statusCode == HttpStatus.badRequest) {
        String errorMessage = decodedJson['message'] ?? 'Bad Request';
        throw AuthenticationException(errorMessage);
      } else {
        throw AuthenticationException(
            "Failed to register user: ${response.statusCode}");
      }
    } on AuthenticationException {
      rethrow;
    } catch (e) {
      throw Exception("Error during registration: $e");
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      var client = HttpClient();
      var request = await client.postUrl(Uri.parse(AuthenticationAPI.login));
      request.headers.set('content-type', 'application/json');
      request.write(jsonEncode({
        "email": email,
        "password": password,
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

      // Handle different status codes
      if (response.statusCode == HttpStatus.ok) {
        if (decodedJson['metadata'] is Map<String, dynamic>) {
          await secureStorage.write(
              key: ApiConfig.token,
              value: decodedJson['metadata']['accessToken']);
          await secureStorage.write(
              key: ApiConfig.refreshToken,
              value: decodedJson['metadata']['refreshToken']);
          return true;
        } else {
          throw InvalidUserDataException("Invalid user data format");
        }
      } else if (response.statusCode == HttpStatus.unauthorized) {
        String errorMessage = decodedJson['message'] ?? 'Unauthorized access';
        throw AuthenticationException(errorMessage);
      } else {
        throw AuthenticationException(
            "Failed to login user: ${response.statusCode}");
      }
    } on AuthenticationException {
      rethrow;
    } catch (e) {
      throw Exception("Error during login: $e");
    }
  }

  Future<void> logOutUser() async {
    await secureStorage.delete(key: ApiConfig.token);
    await secureStorage.delete(key: ApiConfig.refreshToken);
  }

  Future<void> refreshAccessToken() async {
    try {
      String? refreshToken =
          await secureStorage.read(key: ApiConfig.refreshToken);

      if (refreshToken == null || refreshToken.isEmpty) {
        throw AuthenticationException("Refresh token is null or empty");
      }

      var client = HttpClient();
      var request =
          await client.postUrl(Uri.parse(AuthenticationAPI.refreshToken));
      request.headers.set('content-type', 'application/json');
      request.write(jsonEncode({"refreshToken": refreshToken}));

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
        if (decodedJson.containsKey('metadata') &&
            decodedJson['metadata'] is Map<String, dynamic>) {
          Map<String, dynamic> metadata = decodedJson['metadata'];

          // Extract new tokens
          String? newAccessToken = metadata['accessToken'];
          String? newRefreshToken = metadata['refreshToken'];

          if (newAccessToken == null || newAccessToken.isEmpty) {
            throw Exception("New access token is null or empty");
          }
          if (newRefreshToken == null || newRefreshToken.isEmpty) {
            throw Exception("New refresh token is null or empty");
          }

          // Store the new tokens
          await secureStorage.write(
              key: ApiConfig.token, value: newAccessToken);
          await secureStorage.write(
              key: ApiConfig.refreshToken, value: newRefreshToken);
        } else {
          throw InvalidUserDataException("Invalid user data format");
        }
      } else if (response.statusCode == HttpStatus.unauthorized) {
        throw AuthenticationException("Refresh token expired");
      } else {
        throw AuthenticationException(
            "Failed to refresh token: ${response.statusCode}");
      }
    } on AuthenticationException {
      rethrow;
    } catch (e) {
      throw Exception("Error during token refresh: $e");
    }
  }

  Future<AppUser> getUser() async {
    String? token = await secureStorage.read(key: ApiConfig.token);
    String? refreshToken =
        await secureStorage.read(key: ApiConfig.refreshToken);
    try {
      var client = HttpClient();
      var request = await client.getUrl(Uri.parse(UserAPI.getUserPrivate));
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
        AppUser user = AppUser.fromJson(decodedJson['metadata']);
        return user;
      } else if (response.statusCode == HttpStatus.unauthorized) {
        // Token expired, try refreshing it
        try {
          if (refreshToken == null) {
            throw AuthenticationException("Refresh token is null");
          }
          await refreshAccessToken();
          return getUser();
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
      throw Exception("Error during get user: $e");
    }
  }
}
