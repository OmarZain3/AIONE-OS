/// Authenticated user profile.
class AuthUser {
  const AuthUser({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.isActive,
  });

  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String fullName;
  final bool isActive;

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      fullName: json['full_name'] as String? ?? json['email'] as String,
      isActive: json['is_active'] as bool? ?? true,
    );
  }
}
