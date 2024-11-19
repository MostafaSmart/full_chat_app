import 'package:chatapp_front/features/authentication/data/models/user_model.dart';
import 'package:chatapp_front/features/chat/domain/entities/chat.dart';

class ChatModel extends ChatEnt{
ChatModel({ super.id, super.user1,super.user2,super.other_user,super.timestamp});



  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      user1: json['user1'],
      user2: json['user2'],

      other_user : UserModel.fromJson(json['other_user']),

   
      timestamp: DateTime.parse(json['created_at'])
 
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "id": id,
"user1": user1,
"user2": user2,
"other_user": other_user!.toJson(),

"timestamp":timestamp?.toIso8601String()

    };
  }


}