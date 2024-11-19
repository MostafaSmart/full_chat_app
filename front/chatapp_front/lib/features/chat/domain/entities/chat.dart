import 'package:chatapp_front/features/authentication/data/models/user_model.dart';

class ChatEnt {
  int? id;  
  int? user1;
  int? user2;
   DateTime? timestamp;

  UserModel? other_user;


  ChatEnt(
      {this.id,
      this.user1,
      this.user2,
      this.timestamp,
      this.other_user,
   });

  // @override
  // String toString() {
  //   return 'User{id: $id, email: $email, fullName: $fullName}';
  // }
}
