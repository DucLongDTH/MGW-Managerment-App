import 'package:app_demo_flutter/data/datasource_remote/auth_remote_datasource.dart';
import 'package:app_demo_flutter/data/model/base_response/base_response.dart';
import 'package:app_demo_flutter/data/model/login_response_model/login_response_model.dart';
import 'package:app_demo_flutter/data/model/logout_request/logout_request.dart';
import 'package:app_demo_flutter/domain/repositories/auth_repositories.dart';
import 'package:app_demo_flutter/domain/usecases/login_usecase/login_usecase.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteSource;

  AuthRepositoryImpl({required this.remoteSource});

  @override
  Future<Either<Exception, BaseResponse<LoginResponseModel>>> login(
      LoginParams params) {
    return remoteSource.login(params);
  }

  @override
  Future<Either<Exception, BaseResponse<dynamic>>> logout(LogoutRequest logoutRequest) {
    return remoteSource.logout(logoutRequest);
  }
}
