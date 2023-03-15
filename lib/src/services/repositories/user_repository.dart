import 'dart:convert';

import 'package:nanni_chat/src/models/user.dart';

import '../../config.dart';
import 'package:dio/dio.dart';

class UserRepository {
  var dio = Dio();
  Future<User?> getUser(userId) async {
    try {
      final response = await dio
          .get('${SERVER_URL}/getUser?userId=$userId')
          .catchError((error) {
        print(error);
      });
      User user = User.fromJson(response.data['user']);
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> createProfile(
      String username, String userId, String avatar) async {
    try {
      var body = {'username': username, 'userId': userId, 'avatar': avatar};
      var response = await dio.post('${SERVER_URL}/createProfile', data: body);
      return response.data;
    } catch (err) {
      print("error $err");
    }
  }
}
