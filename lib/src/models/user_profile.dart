import 'package:hive/hive.dart';

import 'user.dart';

@HiveType(typeId: 0)
class UserProfile extends User {
  @HiveField(0)
  String? userId;
  @HiveField(1)
  String? username;
  UserProfile({
    this.username,
    this.userId,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        userId: json["user_id"],
        username: json["username"],
      );
  factory UserProfile.fromJsonLocal(Map<String, dynamic> json) => UserProfile(
        userId: json["user_id"],
        username: json["username"],
      );
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
    };
  }

  Map<String, dynamic> toLocalDatabaseMap() {
    Map<String, dynamic> map = {};
    map['user_id'] = userId;
    map['username'] = username;
    return map;
  }

  UserProfile.fromLocalDatabaseMap(Map<String, dynamic> json) {
    userId = json['userId'];
    username = json['username'];
  }

  @override
  String toString() {
    return '{"userId":"$userId","username":"$username"}';
  }
}
