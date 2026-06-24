import 'package:http/http.dart' as http;

import 'package:founder_studio/domain/auth/auth_repository.dart';

/// HTTP client that attaches JWT credentials and refreshes on 401.
class AuthenticatedHttpClient extends http.BaseClient {
  AuthenticatedHttpClient({
    required AuthRepository authRepository,
    http.Client? inner,
  }) : _authRepository = authRepository,
       _inner = inner ?? http.Client();

  final AuthRepository _authRepository;
  final http.Client _inner;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final token = _authRepository.accessToken;
    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    var response = await _inner.send(request);
    if (response.statusCode != 401 || token == null) {
      return response;
    }

    await _authRepository.refreshTokens();
    final refreshedToken = _authRepository.accessToken;
    if (refreshedToken == null) {
      return response;
    }

    final retry = _cloneRequest(request);
    retry.headers['Authorization'] = 'Bearer $refreshedToken';
    response = await _inner.send(retry);
    return response;
  }

  http.BaseRequest _cloneRequest(http.BaseRequest request) {
    if (request is http.Request) {
      return http.Request(request.method, request.url)
        ..headers.addAll(request.headers)
        ..bodyBytes = request.bodyBytes;
    }
    final clone = http.StreamedRequest(request.method, request.url);
    clone.headers.addAll(request.headers);
    return clone;
  }

  @override
  void close() {
    _inner.close();
    super.close();
  }
}
