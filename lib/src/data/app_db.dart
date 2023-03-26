import 'package:drift/drift.dart';
import 'package:nanni_chat/src/common/constants.dart';

import 'app_database.dart';
import '../models/message.dart' as MessageModel;

class AppDB {
  static late AppDatabase _database;
  static Future<void> init(AppDatabase globalDatabase) async {
    _database = globalDatabase;
  }

  static Future<void> insertMessage(Map message) async {
    _database.into(_database.messages).insert(MessagesCompanion.insert(
        userId: message['userId'],
        from: message['from'],
        to: message['to'],
        messageBody: message['messageBody'],
        messageType: message['messageType'],
        isRead: false,
        createdAt: DateTime.now()));
  }

  static Future<void> insertChat(Chat chat) async {
    _database.into(_database.chats).insert(ChatsCompanion.insert(
        userId: chat.userId,
        latestMessage: chat.latestMessage,
        isRead: chat.isRead,
        updatedAt: chat.updatedAt));
  }

  static Future<List<Message>> getMessage(String userId, {offset = 0}) async {
    final allMessage = await (_database.select(_database.messages)
          ..where((tbl) => tbl.userId.equals(userId))
          ..limit(maxMessage, offset: offset)
          ..orderBy([
            (u) =>
                OrderingTerm(expression: u.createdAt, mode: OrderingMode.desc)
          ]))
        .get();
    return allMessage;
  }
}
