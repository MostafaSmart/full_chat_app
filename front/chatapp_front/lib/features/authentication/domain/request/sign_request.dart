class SignRequest {
  String? name;
  String? user_name;
  String? email;
  String? phone;
  String? password;

  SignRequest._({
    this.name,
    this.user_name,
    this.phone,
    this.email,
    this.password,
  });

  factory SignRequest.withEmail({
    required String email,
    required String name,
    String? phone,
    required String user_name,
    required String password,
  }) {
    return SignRequest._(
      email: email,
      name: name,
      phone: phone,
      user_name:user_name,
      password: password,
    );
  }


  Map<String, String?> toJson() {
    return {
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (name != null) 'name': name,
      if (user_name != null) 'user_name': user_name,
      if (password != null) 'password': password,
    
    };
  }
}

class LoginRequest {
  String? email;

  String? password;

  LoginRequest._({
    this.email,
    this.password,
  });

  factory LoginRequest.withEmail({
    required String email,
    required String password,
  }) {
    return LoginRequest._(
      email: email,
      password: password,
    );
  }


  Map<String, String?> toJson() {
    return {
      if (email != null) 'email': email,
      if (password != null) 'password': password,
    
    };
  }


  
  
}



class OTPRequest {
  String? verification_code;

 

  OTPRequest._({
    this.verification_code,
    
  });

  factory OTPRequest.withs({
    required String verification_code,

  }) {
    return OTPRequest._(
      verification_code: verification_code,
 
    );
  }



  Map<String, String?> toJson() {
    return {
      if (verification_code != null) 'verification_code': verification_code,
 
    
    };
  }


  
  
}
