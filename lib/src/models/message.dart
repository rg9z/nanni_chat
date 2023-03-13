import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
part 'message.g.dart';

enum MessageType { text, voice, image, location }

extension MessageStatusValue on MessageStatus {
  String valueAsString() {
    return describeEnum(this);
  }
}

enum MessageStatus { sending, send, received }

extension MessageTypeValue on MessageType {
  String valueAsString() {
    return describeEnum(this);
  }
}

@HiveType(typeId: 1)
class Message {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? chatId;
  @HiveField(2)
  String? from;
  @HiveField(3)
  String? to;
  @HiveField(4)
  String? messageBody;
  @HiveField(5)
  String? messageType;
  @HiveField(6)
  bool? read;
  @HiveField(7)
  String? createdAt;

  Message(
      {this.id,
      this.from,
      this.to,
      this.messageBody,
      this.messageType,
      this.read = false,
      this.chatId,
      this.createdAt});
  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json['id'] ?? '',
        from: json['from'] ?? '',
        to: json['to'] ?? '',
        messageBody: json['messageBody'] ?? '',
        messageType: json['messageType'] ?? 'text',
        read: json['read'] ?? false,
        createdAt: json['createdAt'],
        chatId: json['chat_id'],
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "chat_id": chatId,
        "message_body": messageBody,
        "message_type": messageType,
        "read": read,
        "created_at": createdAt,
      };
}
