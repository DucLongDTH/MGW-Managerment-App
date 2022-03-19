import 'package:dartz/dartz.dart';

abstract class DemoRepository {
  Future<Either<Exception, dynamic>> getCustomer();
}
