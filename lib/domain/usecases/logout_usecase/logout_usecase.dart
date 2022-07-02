import 'dart:async';
import 'package:app_demo_flutter/config/base_config/base_usecase.dart';
import 'package:app_demo_flutter/data/model/base_response/base_response.dart';
import 'package:app_demo_flutter/data/model/logout_request/logout_request.dart';
import 'package:app_demo_flutter/domain/repositories/auth_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LogoutUseCase
    implements UseCase<BaseResponse<dynamic>, LogoutParams> {
  final AuthRepository authRepository;

  LogoutUseCase({required this.authRepository});

  @override
  Future<Either<Exception, BaseResponse<dynamic>>> call(
      LogoutParams params) {
    return authRepository.logout(params.logoutRequest);
  }
}

class LogoutParams extends Equatable {
  final LogoutRequest logoutRequest;
  const LogoutParams({required this.logoutRequest});
  @override
  List<Object?> get props => [];
}
