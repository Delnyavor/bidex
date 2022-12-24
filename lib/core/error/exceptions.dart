class ServerException implements Exception {
  final int? code;
  const ServerException({this.code});
}

class CacheException implements Exception {}
