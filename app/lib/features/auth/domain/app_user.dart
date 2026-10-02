enum UserRole {
  teacher('TEACHER'),
  admin('ADMIN');

  const UserRole(this.wire);
  final String wire;

  static UserRole fromWire(String wire) => UserRole.values.firstWhere(
        (r) => r.wire == wire,
        orElse: () => throw FormatException('Rôle inconnu', wire),
      );
}

/// The authenticated user, as confirmed by the server (`me.get`).
sealed class AppUser {
  const AppUser({required this.email, required this.displayName});

  final String email;
  final String displayName;

  UserRole get role;

  Map<String, Object?> toJson();

  static AppUser fromJson(Map<String, Object?> json) {
    final role = UserRole.fromWire(json['role']! as String);
    final email = json['email']! as String;
    final displayName = (json['displayName'] as String?) ?? email;
    return switch (role) {
      UserRole.teacher => Teacher(
          email: email,
          displayName: displayName,
          groupId: json['groupId']! as String,
          groupName: json['groupName'] as String? ?? json['groupId']! as String,
        ),
      UserRole.admin => AdminUser(email: email, displayName: displayName),
    };
  }
}

/// A teacher belongs to exactly one group (validated decision Q9).
class Teacher extends AppUser {
  const Teacher({
    required super.email,
    required super.displayName,
    required this.groupId,
    required this.groupName,
  });

  final String groupId;
  final String groupName;

  @override
  UserRole get role => UserRole.teacher;

  @override
  Map<String, Object?> toJson() => {
        'email': email,
        'displayName': displayName,
        'role': role.wire,
        'groupId': groupId,
        'groupName': groupName,
      };
}

/// Reads every group, validates sessions, never edits grades.
class AdminUser extends AppUser {
  const AdminUser({required super.email, required super.displayName});

  @override
  UserRole get role => UserRole.admin;

  @override
  Map<String, Object?> toJson() => {
        'email': email,
        'displayName': displayName,
        'role': role.wire,
      };
}

/// Result of a successful `auth.google` / `auth.pin`.
class AuthSession {
  const AuthSession({
    required this.token,
    required this.expiresAt,
    required this.user,
  });

  final String token;
  final DateTime expiresAt;
  final AppUser user;

  bool isExpiredAt(DateTime now) => !now.isBefore(expiresAt);

  Map<String, Object?> toJson() => {
        'token': token,
        'expiresAt': expiresAt.toUtc().toIso8601String(),
        'user': user.toJson(),
      };

  factory AuthSession.fromJson(Map<String, Object?> json) => AuthSession(
        token: json['token']! as String,
        expiresAt: DateTime.parse(json['expiresAt']! as String),
        user: AppUser.fromJson(json['user']! as Map<String, Object?>),
      );
}
