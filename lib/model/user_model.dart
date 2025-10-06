import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final String name;
  final String role;
  final String? token;

  const User({
    required this.username,
    required this.name,
    required this.role,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      name: json['name'],
      role: json['role'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'username': username, 'name': name, 'role': role, 'token': token};
  }

  User copyWith({String? username, String? name, String? role, String? token}) {
    return User(
      username: username ?? this.username,
      name: name ?? this.name,
      role: role ?? this.role,
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props => [username, name, role, token];
}
