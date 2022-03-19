import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'demo_service.g.dart';

//https://pub.dev/packages/retrofit#multiple-endpoints-support
//If you want to use multiple endpoints to your RestClient, you should pass your base url when you initiate RestClient. Any value defined in RestApi will be ignored.
@RestApi()
abstract class DemoService {
  factory DemoService(Dio dio, {String baseUrl}) = _DemoService;

  @GET(
      '/api/v2/customer')
  Future<HttpResponse<dynamic>> getCustomer();
}
