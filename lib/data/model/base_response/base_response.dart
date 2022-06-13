import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  final int? statusCode;
  final String? status;
  final String? message;
  final String? error;
  final String? errorCode;
  final T? data;

  const BaseResponse({
    this.statusCode,
    this.status,
    this.message,
    this.error,
    this.errorCode,
    this.data,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseResponseFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);
}
