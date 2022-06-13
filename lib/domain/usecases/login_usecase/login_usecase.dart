import 'dart:async';
import 'package:app_demo_flutter/config/base_config/base_usecase.dart';
import 'package:app_demo_flutter/data/model/base_response/base_response.dart';
import 'package:app_demo_flutter/data/model/login_request/login_request.dart';
import 'package:app_demo_flutter/data/model/login_response_model/login_response_model.dart';
import 'package:app_demo_flutter/domain/repositories/auth_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LoginUseCase
    implements UseCase<BaseResponse<LoginResponseModel>, LoginParams> {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  @override
  Future<Either<Exception, BaseResponse<LoginResponseModel>>> call(
      LoginParams params) {
    return authRepository.login(params);
  }
}

class LoginParams extends Equatable {
  final LoginRequest loginRequest;
  const LoginParams({required this.loginRequest});
  @override
  List<Object?> get props => [];
}
