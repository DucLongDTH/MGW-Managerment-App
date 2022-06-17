import 'package:app_demo_flutter/data/model/base_response/base_response.dart';
import 'package:app_demo_flutter/data/model/login_request/login_request.dart';
import 'package:app_demo_flutter/data/model/login_response_model/login_response_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_service.g.dart';

//https://pub.dev/packages/retrofit#multiple-endpoints-support
//If you want to use multiple endpoints to your RestClient, you should pass your base url when you initiate RestClient. Any value defined in RestApi will be ignored.
@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST('/api/v2/auth/login')
  Future<HttpResponse<BaseResponse<LoginResponseModel>>> login(
      @Body() LoginRequest loginRequest);
}
