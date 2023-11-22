import 'package:freezed_annotation/freezed_annotation.dart';


part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User{

 const factory User({
    required String token,
    required String email,
    required String isAdmin,
    required Shipping shippingAddress
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);

}

@freezed
class Shipping with _$Shipping{

  const factory Shipping({
    required bool isEmpty,
    required String address,
    required String city
  }) = _Shipping;

  factory Shipping.fromJson(Map<String, Object?> json) => _$ShippingFromJson(json);
  }





