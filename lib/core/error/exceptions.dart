class ServerException implements Exception {
  //TODO: make this required
  final String? message;
  const ServerException({this.message});

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "Exception";
    return "$message";
  }
}

class CacheException implements Exception {}
