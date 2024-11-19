


import 'package:chatapp_front/features/authentication/domain/entities/user.dart';

class UserModel extends UserEnt {
  UserModel(
      {super.name,
      super.phone,
      super.email,
      super.id,
      super.userType,
      super.user_name,

      super.profilePicture,
      super.email_verified_at
     });


     
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name : json['name'],
      email: json['email'],
 
      profilePicture: null,
      userType :null,
      email_verified_at : json['email_verified_at'],
      phone :null,
      user_name: json['user_name']
 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'userType':userType,
      'name': name,
      'user_name': user_name,
      'phone': phone,
      'profilePicture':profilePicture,
      'email_verified_at':email_verified_at

    };
  }
}
