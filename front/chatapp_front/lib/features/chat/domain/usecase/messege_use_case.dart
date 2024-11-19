

import 'package:chatapp_front/features/chat/data/repositories/messeges_repository_impl.dart';
import 'package:chatapp_front/features/chat/domain/request/chat_request.dart';
import 'package:dartz/dartz.dart';
import 'package:chatapp_front/core/api/Failure_class.dart';
import 'package:chatapp_front/core/api/success.dart';


class SendMessegeUseCase {
  final MessegesRepository repository = MessegesRepositorImpl() ;

  SendMessegeUseCase();
  Future<Either<Failure, Success>> call(NewMessegeRequest request) async {
    return await repository.sendNewMesseg(request);
  }
}