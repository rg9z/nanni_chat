import 'package:hive/hive.dart';

import 'message.dart';
import 'user.dart';
part 'chat.g.dart';

@HiveType(typeId: 2)
class Chat extends HiveObject{
  @HiveField(0)
  String? uid;
  @HiveField(1)
  User user;
  @HiveField(2)
  Message latestMessage;
  @HiveField(3)
  String? updateAt;
  @HiveField(4)
  bool? isRead;
  Chat(
      {required this.uid,
      required this.user,
      required this.latestMessage,
      this.updateAt,
      this.isRead = false,});

}
