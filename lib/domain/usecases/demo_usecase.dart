import 'dart:async';
import 'package:app_demo_flutter/config/base_config/base_usecase.dart';
import 'package:app_demo_flutter/domain/repositories/demo_repositories.dart';
import 'package:dartz/dartz.dart';

class DemoUseCase
    implements UseCase<dynamic, NoParams> {
  final DemoRepository  demoRepository;

  DemoUseCase({required this.demoRepository});

  @override
  Future<Either<Exception, dynamic>> call(
      NoParams params) {
    return demoRepository.getCustomer();
  }
}

// class DemoParams extends Equatable {
//   const DemoParams();
//   @override
//   List<Object?> get props => [];
// }
