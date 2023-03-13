import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  String? userId;
  @HiveField(1)
  String? username;
  User({
    this.username,
    this.userId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
    };
  }

  @override
  String toString() {
    return '{"userId":"$userId","username":"$username"}';
  }
}
