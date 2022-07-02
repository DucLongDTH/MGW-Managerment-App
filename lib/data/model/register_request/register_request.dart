import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;

  const RegisterRequest({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return _$RegisterRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! RegisterRequest) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      firstName.hashCode ^
      lastName.hashCode ^
      email.hashCode ^
      password.hashCode;
}
