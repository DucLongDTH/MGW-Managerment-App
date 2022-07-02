import 'dart:async';
import 'package:app_demo_flutter/config/base_config/base_usecase.dart';
import 'package:app_demo_flutter/data/model/base_response/base_response.dart';
import 'package:app_demo_flutter/data/model/logout_request/logout_request.dart';
import 'package:app_demo_flutter/data/model/register_request/register_request.dart';
import 'package:app_demo_flutter/domain/repositories/auth_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RegisterUseCase implements UseCase<BaseResponse<dynamic>, RegisterParams> {
  final AuthRepository authRepository;

  RegisterUseCase({required this.authRepository});

  @override
  Future<Either<Exception, BaseResponse<dynamic>>> call(RegisterParams params) {
    return authRepository.register(params.registerRequest);
  }
}

class RegisterParams extends Equatable {
  final RegisterRequest registerRequest;
  const RegisterParams({required this.registerRequest});
  @override
  List<Object?> get props => [];
}
