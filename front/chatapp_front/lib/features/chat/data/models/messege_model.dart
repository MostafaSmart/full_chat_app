


import 'package:chatapp_front/features/chat/data/models/file_model.dart';
import 'package:chatapp_front/features/chat/domain/entities/messege.dart';

class MessegeModel extends MessegeEnt {
  MessegeModel(
      {super.id,
      super.conversation_id,
      super.content,
      super.is_read,
      super.is_received,
      super.file,
      super.sender_id,
      super.timestamp
     });


     
  factory MessegeModel.fromJson(Map<String, dynamic> json) {
    return MessegeModel(
      id: json['id'],
      conversation_id : json['conversation_id'],
      content: json['content'],
      is_read: json['is_read'],
      is_received: json['is_received'],
      file:  json['file'] != null ?FileModle.fromJson(json['file']): null,
      sender_id: json['sender_id'],
      timestamp: DateTime.parse(json['created_at'])
 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
"conversation_id": conversation_id,
"sender_id": sender_id,
"content": content,
"is_read": is_read,
"is_received": is_received,
"file" : file!=null? file!.toJson() : null,
"timestamp":timestamp?.toIso8601String()

    };
  }
}
