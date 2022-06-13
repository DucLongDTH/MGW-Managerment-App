import 'package:app_demo_flutter/data/service/product_service.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class ProductRemoteDataSource {
  Future<Either<Exception, dynamic>> getProduct();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  ProductService service;
  Options? options;
  ProductRemoteDataSourceImpl({required this.service});

  @override
  Future<Either<Exception, dynamic>> getProduct() async {
    try {
      return const Right([]);
    } on Exception catch (error) {
      return Left(error);
    }
  }
}
