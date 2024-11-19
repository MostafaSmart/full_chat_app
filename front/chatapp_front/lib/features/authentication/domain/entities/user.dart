class UserEnt {
  int? id;
  String? email;
  String? user_name;

  String? phone;

  String? name;
  String? profilePicture;
  String? userType;
  String? email_verified_at;

  UserEnt(
      {this.id,
      this.email,
      this.user_name,
      this.name,
      this.phone,
      this.profilePicture,
      this.userType,
      this.email_verified_at});

  // @override
  // String toString() {
  //   return 'User{id: $id, email: $email, fullName: $fullName}';
  // }
}
