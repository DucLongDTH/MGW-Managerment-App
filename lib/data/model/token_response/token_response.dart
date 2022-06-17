import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token_response.g.dart';

@JsonSerializable()
class TokenResponse {
  final String? accessToken;
  final String? refreshToken;

  const TokenResponse({this.accessToken, this.refreshToken});

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return _$TokenResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! TokenResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => accessToken.hashCode ^ refreshToken.hashCode;
}
