import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'product_service.g.dart';

//https://pub.dev/packages/retrofit#multiple-endpoints-support
//If you want to use multiple endpoints to your RestClient, you should pass your base url when you initiate RestClient. Any value defined in RestApi will be ignored.
@RestApi()
abstract class ProductService {
  factory ProductService(Dio dio, {String baseUrl}) = _ProductService;
}
