/// JWT access and refresh token pair.
class AuthTokens {
  const AuthTokens({required this.accessToken, required this.refreshToken});

  final String accessToken;
  final String refreshToken;

  factory AuthTokens.fromJson(Map<String, dynamic> json) {
    return AuthTokens(
      accessToken: json['access'] as String,
      refreshToken: json['refresh'] as String,
    );
  }

  Map<String, String> toJson() => {
    'access': accessToken,
    'refresh': refreshToken,
  };

  AuthTokens copyWith({String? accessToken, String? refreshToken}) {
    return AuthTokens(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
