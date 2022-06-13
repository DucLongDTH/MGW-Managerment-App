import 'dart:async';
import 'package:app_demo_flutter/config/base_config/base_usecase.dart';
import 'package:app_demo_flutter/domain/repositories/product_repositories.dart';
import 'package:dartz/dartz.dart';

class GetProductUseCase implements UseCase<dynamic, NoParams> {
  final ProductRepository productRepository;

  GetProductUseCase({required this.productRepository});

  @override
  Future<Either<Exception, dynamic>> call(NoParams params) {
    return productRepository.getProduct();
  }
}

// class DemoParams extends Equatable {
//   const DemoParams();
//   @override
//   List<Object?> get props => [];
// }
