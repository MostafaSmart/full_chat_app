import 'dart:convert';

import 'package:chatapp_front/core/api/Failure_class.dart';
import 'package:chatapp_front/core/api/api_conest.dart';
import 'package:chatapp_front/core/api/exception.dart';
import 'package:chatapp_front/core/api/success.dart';
import 'package:chatapp_front/core/hive/auth_hive.dart';
import 'package:chatapp_front/features/authentication/data/models/user_model.dart';
import 'package:chatapp_front/features/authentication/domain/request/sign_request.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSources {
  Future<Success> registerWithEmail(SignRequest request);
  Future<Success> loginWithEmail(LoginRequest request);
  Future<Success> getVerCode();

  Future<Success> sendVerification(OTPRequest request);
}

class AuthRemoteDataSourcesImpl implements AuthRemoteDataSources {
  final http.Client client = http.Client();

  @override
  Future<Success> registerWithEmail(SignRequest request) async {
    final url =
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.REGISTER_USER}');
    final headers = {
      'Content-Type': 'application/json',
    };

    final response = await _postHandleErrors(
        urlEndPoind: url, headers: headers, data: request.toJson());

    final UserModel userModel = UserModel.fromJson(response.data['user']);

    AuthBox.setCurrentUserData(userModel);
    AuthBox.setUserEmailValid(
        userModel.email_verified_at != null ? true : false);
    AuthBox.setUserLoggedIn(true);
    AuthBox.setAuthToken(response.data['token']);

    return response;
  }

  @override
  Future<Success> getVerCode() async {
    final url =
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getVerify_Code}');

    final headers = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer ' + AuthBox.getAuthToken()!
    };

    print('acsssss ' + AuthBox.getAuthToken()!);
    return await _getHandleErrors(urlEndPoind: url, headers: headers);
  }

  @override
  Future<Success> loginWithEmail(LoginRequest request) async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.LOGIN}');
    final headers = {
      'Content-Type': 'application/json',
    };

    final response = await _postHandleErrors(
        urlEndPoind: url, headers: headers, data: request.toJson());

    final UserModel userModel = UserModel.fromJson(response.data['user']);

    AuthBox.setCurrentUserData(userModel);
    AuthBox.setUserEmailValid(
        userModel.email_verified_at != null ? true : false);
    AuthBox.setUserLoggedIn(true);
    AuthBox.setAuthToken(response.data['token']);

    return response;
  }

  @override
  Future<Success> sendVerification(OTPRequest request) async {
    final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.send_verify_Code_Email}');
    final headers = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer ' + AuthBox.getAuthToken()!
    };

    final response = await _postHandleErrors(
        urlEndPoind: url, headers: headers, data: request.toJson());

    final UserModel userModel = UserModel.fromJson(response.data['user']);

    AuthBox.setCurrentUserData(userModel);
    AuthBox.setUserEmailValid(
        userModel.email_verified_at != null ? true : false);
    AuthBox.setUserLoggedIn(true);
    AuthBox.setAuthToken(response.data['token']);

    return response;
  }

  Future<Success> _getHandleErrors({
    required Uri urlEndPoind,
    Map<String, String>? headers,
  }) async {
    // try {
    final response = await http.get(urlEndPoind, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final utf8DecodedBody = utf8.decode(response.bodyBytes);
      final chatDate = jsonDecode(utf8DecodedBody);

      return ServerSuccess('get done!', code: '200', data: chatDate);
    } else {
      print(response.statusCode.toString() + "  ${response.body}");

      throw AppException(ServerFailure(
          message: 'Error',
          code: response.statusCode.toString(),
          errors: response.body));

    }
    // }
    // catch (e) {
    //   print("pointr erore : $e ");

    //   throw AppException(
    //       ServerFailure(message: 'unknown Error', code: '500', errors: e));
    // }
  }

  Future<Success> _postHandleErrors(
      {required Uri urlEndPoind,
      Map<String, String>? headers,
      Object? data}) async {
    // try {
    print(data);
    final response =
        await http.post(urlEndPoind, headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final utf8DecodedBody = utf8.decode(response.bodyBytes);
      final chatDate = jsonDecode(utf8DecodedBody);

      return ServerSuccess('post done!', code: '200', data: chatDate);
    } else {
      print(response.statusCode.toString() + "  ${response.body}");

      throw AppException(ServerFailure(
          message: 'Error',
          code: response.statusCode.toString(),
          errors: response.body));
    }
    // }
    // catch (e) {
    //   print("pointr erore : $e");

    //   throw AppException(
    //       ServerFailure(message: 'unknown Error', code: '500', errors: e));
    // }
  }
}
//   final db = FirebaseFirestore.instance;

//   @override
//   Future<Success> registerWithEmail(SignRequest request) async {
//     try {
//       final credential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(
//               email: request.email!, password: request.password!);

//       final user = UserModel(
//           id: credential.user!.uid,
//           fullName: request.fullName,
//           phone: request.phone,
//           userType: 'user',
//           email: request.email,
//           emailValid: credential.user!.emailVerified,
//           profilePicture: null);

//       await db.collection("users").doc(user.id).set(user.toJson());

//       return ServerSuccess('sign up done!', code: '200', data: user);
//     } on FirebaseAuthException catch (e) {
//       print(e.code + "  aaaaaaaaaaaa" + e.message!);
//       throw AppException(ServerFailure(
//           message: 'FireAuth Error', code: '400', errors: e.code));
//     } on FirebaseException catch (e) {
//       // لمعالجة أخطاء Firestore
//       print(e.message);
//       throw AppException(ServerFailure(
//           message: 'Firestore Error', code: '500', errors: e.message));
//     } catch (e) {
//       print(e);
//       throw AppException(
//           ServerFailure(message: 'unknown Error', code: '500', errors: e));
//     }
//   }

//   @override
//   Future<Success> loginWithEmail(LoginRequest request) async {
//     try {

//       final credential =   await FirebaseAuth.instance.signInWithEmailAndPassword(email: request.email!, password: request.password!);

//      final docoment =   await db.collection("users").doc(credential.user!.uid).get();

//         await credential.user!.reload();
//       if (!docoment.exists){
//          throw AppException(ServerFailure(
//           message: 'Firestore Error', code: '500', errors: 'user dosent found'));
//       }

//       final UserModel userModel = UserModel.fromJson(docoment.data()!);
//       userModel.emailValid = credential.user!.emailVerified;
//       AuthBox.setCurrentUserData(userModel);
//       AuthBox.setUserEmailValid(userModel.emailValid!);
//       AuthBox.setUserLoggedIn(true);

//       return ServerSuccess('login done!', code: '200', data: userModel);

//     }

//     on FirebaseAuthException catch (e) {
//       print(e.code + "  login" + e.message!);
//       throw AppException(ServerFailure(
//           message: 'FireAuth Error login', code: '400', errors: e.code));
//     }

//      on FirebaseException catch (e) {
//       // لمعالجة أخطاء Firestore
//       print(e.message);
//       throw AppException(ServerFailure(
//           message: 'Firestore Error login', code: '500', errors: e.message));
//     }

//    catch (e) {
//       print(e);
//       throw AppException(
//           ServerFailure(message: 'unknown Error login', code: '500', errors: e));
//     }

//   }

//   @override
//   Future<Success> sendVerification() async {
//     try {
//       await FirebaseAuth.instance.currentUser!.sendEmailVerification();
//       return ServerSuccess('send Verification done!', code: '200');
//     } on FirebaseAuthException catch (e) {
//       print(e.code);
//       throw AppException(ServerFailure(
//           message: 'send FireAuth Error', code: '400', errors: e.code));
//     } catch (e) {
//       print(e);
//       throw AppException(
//           ServerFailure(message: 'unknown Error', code: '500', errors: e));
//     }
//   }
// }
