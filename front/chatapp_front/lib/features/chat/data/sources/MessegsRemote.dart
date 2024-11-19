import 'dart:convert';

import 'package:chatapp_front/core/api/Failure_class.dart';
import 'package:chatapp_front/core/api/api_conest.dart';
import 'package:chatapp_front/core/api/exception.dart';
import 'package:chatapp_front/core/api/success.dart';
import 'package:chatapp_front/core/hive/auth_hive.dart';
import 'package:chatapp_front/features/chat/data/models/messege_model.dart';
// import 'package:chatapp_front/features/authentication/data/models/user_model.dart';
// import 'package:chatapp_front/features/authentication/domain/request/sign_request.dart';
import 'package:chatapp_front/features/chat/domain/request/chat_request.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:mime/mime.dart';

abstract class MessegsRemoteDataSources {
  Future<Success> sendNewMesseg(NewMessegeRequest request);
}

class MessegsRemoteDataSourcesImpl implements MessegsRemoteDataSources {
  final http.Client client = http.Client();

  @override
  Future<Success> sendNewMesseg(NewMessegeRequest request) async {
    final url =
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.CREATE_Messege}');
    final headers = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer ' + AuthBox.getAuthToken()!
    };
    var response = null;

    if (request.file != null) {
   response =    await _postHandleErrorsWithFile(headers: headers, data: request, urlEndPoind: url);


    } else {

    response =   await _postHandleErrors(headers: headers, data: request.toJson(), urlEndPoind: url);

    }
      
      
      final newMessage = MessegeModel.fromJson(response.data);

      return response;

 





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
      print(response.statusCode.toString() + "  ${response.body.toString()}");

      throw AppException(ServerFailure(
          message: 'Error',
          code: response.statusCode.toString(),
          errors: response.body.toString()));
    }
    // }
    // catch (e) {
    //   print("pointr erore : $e");

    //   throw AppException(
    //       ServerFailure(message: 'unknown Error', code: '500', errors: e));
    // }
  }
}

  Future<Success> _postHandleErrorsWithFile(
      {required Uri urlEndPoind,
      required Map<String, String>? headers,
      required NewMessegeRequest? data}) async {
    var request = http.MultipartRequest('POST', urlEndPoind);
    request.headers.addAll(headers!);

    if (data!.content != null) {
      request.fields['content'] = data.content!;
    }

    request.fields['receiver_id'] = data.receiver_id!;

    try {
      // تحديد نوع الملف بناءً على الامتداد
      var mimeTypeData = lookupMimeType(data.file!)?.split('/');

      if (mimeTypeData == null) {
        print("تعذر تحديد نوع الملف");
        throw AppException(ServerFailure(
            message: 'تعذر تحديد نوع الملف',
            code: '600',
            errors: 'تعذر تحديد نوع الملف'));
      }

      // إنشاء ملف Multipart بناءً على نوع الملف (صورة أو مستند)
      var file = await http.MultipartFile.fromPath(
        'file',
        data.file!,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
      );

      request.files.add(file);

      try {
        var response = await request.send();
        if (response.statusCode == 201 || response.statusCode == 200) {
          var responseData = await http.Response.fromStream(response);

          // فك ترميز النص باستخدام utf8.decode للتعامل مع النصوص العربية
          var decodedBody = utf8.decode(responseData.bodyBytes);

          // تحويل النص المفكوك إلى JSON
          var responseBody = jsonDecode(decodedBody);
          // final newMessage = MessegeModel.fromJson(responseBody);

          print('sacsssssss_remote:');
          print(responseBody);

          return ServerSuccess('post done!', code: '200', data: responseBody);

          // return newMessage;
        } else {
          throw AppException(ServerFailure(
              message: 'خطأ أثناء إرسال الطلب:',
              code: response.statusCode.toString(),
              errors: 'خطأ أثناء إرسال الطلب:'));
        }
      } catch (e) {
        print("خطأ أثناء إرسال الطلب: $e");

        throw AppException(ServerFailure(
            message: 'خطأ أثناء إرسال الطلب:',
            code: '600',
            errors: 'خطأ أثناء إرسال الطلب:'));
      }
    } catch (e) {
      print("خطأ في تحديد MIME type: $e");
      throw AppException(ServerFailure(
          message: 'خخطأ في تحديد MIME typeب:',
          code: '600',
          errors: 'خطأ في تحديد MIME type'));
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
