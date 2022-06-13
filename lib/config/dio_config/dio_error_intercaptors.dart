import 'package:app_demo_flutter/config/dio_config/connecttivity_util.dart';
import 'package:dio/dio.dart';

class DioErrorInterceptors extends Interceptor {
  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        return handler.next(DeadlineExceededException(err));
      case DioErrorType.response:
        switch (err.response?.statusCode) {
          case 400:
            return handler.next(BadRequestException(err));
          case 401:
            return handler.next(UnauthorizedException(err));
          case 404:
            return handler.next(NotFoundException(err));
          case 409:
            return handler.next(ConflictException(err));
          case 500:
            return handler.next(InternalServerErrorException(err));
          case 503:
            return handler.next(ServerUnderMaintainErrorException(err));
        }
        break;
      case DioErrorType.cancel:
      case DioErrorType.other:
        // if (err.message.contains('SocketException')) {
        //   return handler.next(DeadlineExceededException(err));
        // }
        bool hasInternet = await ConnectivityUtil.getInstance()
            .hasInternetInternetConnection();
        if (!hasInternet) {
          return handler.next(NoInternetConnectionException(err));
        } else {
          return handler.next(OtherException(err));
        }
    }

    return handler.next(err); //<------ very important
  }
}

class BadRequestException extends DioError {
  BadRequestException(this.dioError)
      : super(
            requestOptions: dioError.requestOptions,
            type: dioError.type,
            response: dioError.response,
            error: dioError.error);
  final DioError dioError;

  @override
  String toString() {
    return 'Invalid request';
  }
}

class ServerUnderMaintainErrorException extends DioError {
  ServerUnderMaintainErrorException(this.dioError)
      : super(
            requestOptions: dioError.requestOptions,
            type: dioError.type,
            response: dioError.response,
            error: dioError.error);
  final DioError dioError;
  @override
  String toString() {
    return 'Server under maintenance, please try again later.';
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(this.dioError)
      : super(
            requestOptions: dioError.requestOptions,
            type: dioError.type,
            response: dioError.response,
            error: dioError.error);
  final DioError dioError;
  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioError {
  ConflictException(this.dioError)
      : super(
            requestOptions: dioError.requestOptions,
            type: dioError.type,
            response: dioError.response,
            error: dioError.error);
  final DioError dioError;
  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(this.dioError)
      : super(
            requestOptions: dioError.requestOptions,
            type: dioError.type,
            response: dioError.response,
            error: dioError.error);
  final DioError dioError;
  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioError {
  NotFoundException(this.dioError)
      : super(
            requestOptions: dioError.requestOptions,
            type: dioError.type,
            response: dioError.response,
            error: dioError.error);
  final DioError dioError;
  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class OtherException extends DioError {
  OtherException(this.dioError)
      : super(
            requestOptions: dioError.requestOptions,
            type: dioError.type,
            response: dioError.response,
            error: dioError.error);
  final DioError dioError;

  @override
  String toString() {
    return 'Something went wrong, please try again.';
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(this.dioError)
      : super(
            requestOptions: dioError.requestOptions,
            type: dioError.type,
            response: dioError.response,
            error: dioError.error);
  final DioError dioError;

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(this.dioError)
      : super(
            requestOptions: dioError.requestOptions,
            type: dioError.type,
            response: dioError.response,
            error: dioError.error);
  final DioError dioError;
  @override
  String toString() {
    return 'No internet connection, please try again.';
  }
}
