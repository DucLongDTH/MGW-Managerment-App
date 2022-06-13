import 'package:app_demo_flutter/data/service/demo_service.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class DemoRemoteDataSource {
  Future<Either<Exception, dynamic>> getCustomer();
}

class DemoRemoteDataSourceImpl implements DemoRemoteDataSource {
  DemoService service;
  Options? options;
  DemoRemoteDataSourceImpl({required this.service});

  @override
  Future<Either<Exception, dynamic>> getCustomer() async {
    try {
      final response = await service.getCustomer();
      return Right(response.data);
    } on Exception catch (error) {
      return Left(error);
    }
  }
}
