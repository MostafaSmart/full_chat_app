
import 'package:dartz/dartz.dart';
import 'package:chatapp_front/core/api/Failure_class.dart';
import 'package:chatapp_front/core/api/success.dart';
import 'package:chatapp_front/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:chatapp_front/features/authentication/domain/request/sign_request.dart';

class GetVerificationEmailUseCase {
  final AuthRepository repository = AuthRepositorImpl() ;

  GetVerificationEmailUseCase();
  Future<Either<Failure, Success>> call() async {
    return await repository.getVerificationEmail();
  }


}

class SendVerificationEmailUseCase {
  final AuthRepository repository = AuthRepositorImpl() ;

  SendVerificationEmailUseCase();
  Future<Either<Failure, Success>> call(OTPRequest request) async {
    return await repository.sendVerificationEmail(request);
  }

  
}