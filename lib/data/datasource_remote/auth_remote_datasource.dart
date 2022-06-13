import 'package:app_demo_flutter/data/model/base_response/base_response.dart';
import 'package:app_demo_flutter/data/model/login_response_model/login_response_model.dart';
import 'package:app_demo_flutter/data/service/auth_service.dart';
import 'package:app_demo_flutter/domain/usecases/login_usecase/login_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Exception, BaseResponse<LoginResponseModel>>> login(
      LoginParams params);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthService service;
  Options? options;
  AuthRemoteDataSourceImpl({required this.service});

  @override
  Future<Either<Exception, BaseResponse<LoginResponseModel>>> login(
      LoginParams params) async {
    try {
      final response = await service.login(params.loginRequest);
      // TODO SAVE TOKEN TO LOCAL
      return Right(response.data);
    } on Exception catch (error) {
      return Left(error);
    }
  }
}
