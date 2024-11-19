import 'package:chatapp_front/features/authentication/data/models/user_model.dart';
import 'package:hive/hive.dart';


class AuthBox {


   static const boxKey = "authBox";
  static const authToken = "authToken";
  static const currentUserData = "currentUserData";
  static const userLoggedIn = "userLoggedIn";
  static const emailValid = "emailValid";

  static const userType = 'userType';
  static const skip = 'skip';
  static const profileUrl = "ProfileUrl";

  static void setSkip(bool isSkip) {
    Hive.box(AuthBox.boxKey).put(AuthBox.skip, isSkip);
  }

  static bool isSkip() {
    final authBox = Hive.box(AuthBox.boxKey);
    return authBox.get(AuthBox.skip, defaultValue: false);
  }

  static bool isUserLoggedIn() {
    final authBox = Hive.box(AuthBox.boxKey);
    return authBox.get(AuthBox.userLoggedIn, defaultValue: false);
  }

  static void setAuthToken(String token) {
    final authBox = Hive.box(AuthBox.boxKey);
    authBox.put(AuthBox.authToken, token);
  }

  static void setUserLoggedIn(bool isUserLoggedIn) {
    final authBox = Hive.box(AuthBox.boxKey);
    authBox.put(AuthBox.userLoggedIn, isUserLoggedIn);
  }


  
  static void setUserEmailValid(bool? valid) {
    final authBox = Hive.box(AuthBox.boxKey);
    authBox.put(AuthBox.emailValid, valid);
  }

    static bool isUserEmailValid() {
    final authBox = Hive.box(AuthBox.boxKey);
    return authBox.get(AuthBox.emailValid, defaultValue: false);
  }


  static String? getAuthToken() {
    final authBox = Hive.box(AuthBox.boxKey);
    return authBox.get(AuthBox.authToken);
  }

  static void setUserType(String type) {
    Hive.box(boxKey).put(userType, type);
  }

  static String? getUserType() {
    return Hive.box(boxKey).get(userType);
  }

  static void setCurrentUserData(UserModel user) {
    final authBox = Hive.box(AuthBox.boxKey);
    authBox.put(AuthBox.currentUserData, user.toJson());
  }

  static UserModel? getCurrentUserData() {
    final authBox = Hive.box(AuthBox.boxKey);
    final jsonData = authBox.get(AuthBox.currentUserData);

    if (jsonData != null && jsonData is Map<dynamic, dynamic>) {
      final data = Map<String, dynamic>.from(jsonData);
      return UserModel.fromJson(data);
    }
    return null;
  }

  static bool isSellar() => getUserType() == 'sellar';

  static void logout() {
    final authBox = Hive.box(AuthBox.boxKey);
    authBox.delete(AuthBox.authToken);
    authBox.delete(AuthBox.userLoggedIn);
    authBox.delete(AuthBox.currentUserData);
    authBox.delete(AuthBox.userType);
    authBox.delete(profileUrl);
    authBox.delete(skip);
    print('User logged out successfully.');
  }

  static int? getUserId() {
    var user = getCurrentUserData();

    return user?.id;
    // return _box.get('id');
  }
  static String? name() {
    var user = getCurrentUserData();

    return user?.name;
    // return _box.get('id');
  }
  

  static void setProfileUrl(String urlProfile) {
    Hive.box(AuthBox.boxKey).put(AuthBox.profileUrl, urlProfile);
  }

  static String? getProfileUrl() {
    final authBox = Hive.box(AuthBox.boxKey);
    return authBox.get(AuthBox.profileUrl);
  }
}

