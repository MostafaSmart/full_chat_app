

import 'package:dartz/dartz.dart';
import 'package:chatapp_front/core/api/Failure_class.dart';
import 'package:chatapp_front/core/api/success.dart';
import 'package:chatapp_front/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:chatapp_front/features/authentication/domain/request/sign_request.dart';

class RegisterWithEmailUseCase {
  final AuthRepository repository = AuthRepositorImpl() ;

  RegisterWithEmailUseCase();
  Future<Either<Failure, Success>> call(SignRequest request) async {
    return await repository.registerWithEmail(request);
  }
}