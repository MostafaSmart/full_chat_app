import 'dart:io';

import 'package:chatapp_front/features/chat/data/models/file_model.dart';

class MessegeEnt {
  int? id;
  int? conversation_id;
  int? sender_id;
  

  String? content;

  bool? is_read;
  bool? is_received;
   DateTime? timestamp;
   FileModle? file;



  MessegeEnt(
      {this.id,
      this.conversation_id,
      this.sender_id,
      this.is_read,
      this.file,
      this.content,
      this.timestamp,
      this.is_received});

  // @override
  // String toString() {
  //   return 'User{id: $id, email: $email, fullName: $fullName}';
  // }
}
