import 'package:chatapp_front/features/chat/domain/request/chat_request.dart';
import 'package:dartz/dartz.dart';
import 'package:chatapp_front/core/api/Failure_class.dart';
import 'package:chatapp_front/core/api/error_strings.dart';
import 'package:chatapp_front/core/api/exception.dart';
import 'package:chatapp_front/core/api/success.dart';
import 'package:chatapp_front/core/helper/network_info.dart';
// // import 'package:chatapp_front/core/hive/auth_hive.dart';
// import 'package:chatapp_front/features/authentication/data/sources/auth_remote_data_source.dart';
// import 'package:chatapp_front/features/authentication/domain/request/sign_request.dart';

abstract class MessegesRepository {
  Future<Either<Failure, Success>> sendNewMesseg(NewMessegeRequest request);
  // Future<Either<Failure, Success>> loginWithEmail(LoginRequest request);

  // Future<Either<Failure, Success>> sendVerificationEmail();
}

// //////////////////////////////////////////////////////////////////////////
// ///////////////////////////////////////////////////////////////////

class MessegesRepositorImpl implements MessegesRepository {

  NetworkInfo networkInfo = NetworkInfoImpl();
  MessegesRepository messegesRepository = MessegesRepositorImpl();
  @override
  Future<Either<Failure, Success>> sendNewMesseg(NewMessegeRequest request) async{

var result = await _handleErrors(() async {
      return await messegesRepository.sendNewMesseg(request);
    });


    
    return result is Success ? Right(result) : Left(result);


  }



  Future _handleErrors(Function registerFunc) async {
    try {
      if (await networkInfo.isConnected) {
        return await registerFunc();
      }

      return OfflineFailure(message: ErrorString.OFFLINE_ERROR);
    } on AppException catch (e) {
      print(">>>>>>>>>>Catch AppException in auth repository: ${e.failure}");
      return (e.failure as ServerFailure);
    } catch (e) {
      print(">>>>>>>>>>Catch Exception in auth repository: $e");
      return NotSpecificFailure(message: e.toString());
    }
  }






}
//   AuthRemoteDataSources remoteDataSource = AuthRemoteDataSourcesImpl();

//   @override
//   Future<Either<Failure, Success>> registerWithEmail(
//       SignRequest request) async {
//     var result = await _handleErrors(() async {
//       return await remoteDataSource.registerWithEmail(request);
//     });
//     return result is Success ? Right(result) : Left(result);
//   }

//   @override
//   Future<Either<Failure, Success>> loginWithEmail(LoginRequest request) async {
//     var result = await _handleErrors(() async {
//       return await remoteDataSource.loginWithEmail(request);
//     });

    

//     return result is Success ? Right(result) : Left(result);
//   }

//   @override
//   Future<Either<Failure, Success>> sendVerificationEmail() async {
//     var result = await _handleErrors(() async {
//       return await remoteDataSource.sendVerification();
//     });
//     return result is Success ? Right(result) : Left(result);
//   }

// }