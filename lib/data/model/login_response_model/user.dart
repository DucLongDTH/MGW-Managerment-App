import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String? firstName;
  final String? lastName;
  final dynamic address;
  final String? email;
  final dynamic phone;
  final dynamic gender;
  final dynamic avatarUrl;
  final dynamic coverUrl;
  final int? balance;
  final List<String>? roles;

  const User({
    this.firstName,
    this.lastName,
    this.address,
    this.email,
    this.phone,
    this.gender,
    this.avatarUrl,
    this.coverUrl,
    this.balance,
    this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? firstName,
    String? lastName,
    dynamic address,
    String? email,
    dynamic phone,
    dynamic gender,
    dynamic avatarUrl,
    dynamic coverUrl,
    int? balance,
    List<String>? roles,
  }) {
    return User(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      address: address ?? this.address,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      coverUrl: coverUrl ?? this.coverUrl,
      balance: balance ?? this.balance,
      roles: roles ?? this.roles,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! User) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      firstName.hashCode ^
      lastName.hashCode ^
      address.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      gender.hashCode ^
      avatarUrl.hashCode ^
      coverUrl.hashCode ^
      balance.hashCode ^
      roles.hashCode;
}
