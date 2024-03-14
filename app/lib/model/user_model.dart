import 'dart:convert';

class UserModel {
  final String id;
  final String email;
  final String username;
  UserModel({
    required this.id,
    required this.email,
    required this.username,
  });

  UserModel copyWith({
    String? id,
    String? email,
    String? username,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
    };
  }

  factory UserModel.empty() {
    return UserModel(
      id: '',
      email: '',
      username: '',
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(id: $id, email: $email, username: $username)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.id == id &&
      other.email == email &&
      other.username == username;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ username.hashCode;
}
