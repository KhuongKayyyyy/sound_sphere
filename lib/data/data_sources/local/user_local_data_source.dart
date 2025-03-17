// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sound_sphere/core/error/exceptions.dart';
// import 'package:sound_sphere/data/models/app_user.dart';

// abstract class UserLocalDataSource {
//   Future<String> getToken();
//   Future<AppUser> getUser();
//   Future<void> saveToken(String token);
//   Future<void> saveUser(AppUser user);
//   Future<void> clearCache();
//   Future<bool> isTokenAvailable();
// }

// const cachedToken = 'CACHEDTOKEN';
// const cachedUser = 'CACHEDUSER';

// class UserLocalDataSourceImpl implements UserLocalDataSource {
//   final FlutterSecureStorage secureStorage;
//   final SharedPreferences sharedPreferences;

//   UserLocalDataSourceImpl(
//       {required this.secureStorage, required this.sharedPreferences});
//   @override
//   Future<void> clearCache() async {
//     await secureStorage.delete(key: cachedToken);
//     await sharedPreferences.remove(cachedUser);
//   }

//   @override
//   Future<String> getToken() {
//     throw UnimplementedError();
//   }

//   @override
//   Future<AppUser> getUser() async {
//     if (sharedPreferences.getBool('first-run') ?? true) {
//       await secureStorage.deleteAll();
//       sharedPreferences.setBool('first_run', false);
//     }
//     final jsonString = sharedPreferences.getString(cachedUser);
//     if (jsonString != null) {
//       return Future.value(userModelFromJson(jsonString));
//     } else {
//       throw CacheException();
//     }
//   }

//   @override
//   Future<bool> isTokenAvailable() async {
//     String? token = await secureStorage.read(key: cachedToken);
//     return Future.value((token != null));
//   }

//   @override
//   Future<void> saveToken(String token) async {
//     await secureStorage.write(key: cachedToken, value: token);
//   }

//   @override
//   Future<void> saveUser(AppUser user) {
//     return sharedPreferences.setString(cachedUser, userModelToJson(user));
//   }
// }
