//date
class ServerException implements Exception {}

class CacheException implements Exception {}

//route
class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}

class EmptyResponseException implements Exception {
  final String message;
  EmptyResponseException(this.message);
}

class InvalidJsonFormatException implements Exception {
  final String message;
  InvalidJsonFormatException(this.message);
}

class InvalidUserDataException implements Exception {
  final String message;
  InvalidUserDataException(this.message);
}

class AuthenticationException implements Exception {
  final String message;
  AuthenticationException(this.message);
}
