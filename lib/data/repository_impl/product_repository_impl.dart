import 'package:app_demo_flutter/data/datasource_remote/product_remote_datasource.dart';
import 'package:app_demo_flutter/domain/repositories/product_repositories.dart';
import 'package:dartz/dartz.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteSource;

  ProductRepositoryImpl({required this.remoteSource});

  @override
  Future<Either<Exception, dynamic>> getProduct() {
    return remoteSource.getProduct();
  }
}
