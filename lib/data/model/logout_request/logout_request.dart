import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'logout_request.g.dart';

@JsonSerializable()
class LogoutRequest {
  final String? device;
  final String? platform;

  const LogoutRequest({this.device, this.platform});

  factory LogoutRequest.fromJson(Map<String, dynamic> json) {
    return _$LogoutRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LogoutRequestToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! LogoutRequest) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => device.hashCode ^ platform.hashCode;
}
