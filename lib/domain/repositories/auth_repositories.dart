import 'package:app_demo_flutter/data/model/base_response/base_response.dart';
import 'package:app_demo_flutter/data/model/login_response_model/login_response_model.dart';
import 'package:app_demo_flutter/data/model/logout_request/logout_request.dart';
import 'package:app_demo_flutter/domain/usecases/login_usecase/login_usecase.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Exception, BaseResponse<LoginResponseModel>>> login(
      LoginParams params);
  Future<Either<Exception, BaseResponse<dynamic>>> logout(
      LogoutRequest logoutRequest);    
}
