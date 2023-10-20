enum ApiClientExceptionType { Network, Auth, Other, SessionExpired }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}
