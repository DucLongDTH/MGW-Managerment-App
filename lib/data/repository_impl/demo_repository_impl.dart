import 'package:app_demo_flutter/data/datasource_remote/demo_remote_datasource.dart';
import 'package:app_demo_flutter/domain/repositories/demo_repositories.dart';
import 'package:dartz/dartz.dart';

class DemoRepositoryImpl implements DemoRepository {
  final DemoRemoteDataSource remoteSource;

  DemoRepositoryImpl({required this.remoteSource});

  @override
  Future<Either<Exception, dynamic>> getCustomer() {
    return remoteSource.getCustomer();
  }
}
