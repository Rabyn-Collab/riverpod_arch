// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      token: json['token'] as String,
      email: json['email'] as String,
      isAdmin: json['isAdmin'] as String,
      shippingAddress:
          Shipping.fromJson(json['shippingAddress'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'email': instance.email,
      'isAdmin': instance.isAdmin,
      'shippingAddress': instance.shippingAddress,
    };

_$ShippingImpl _$$ShippingImplFromJson(Map<String, dynamic> json) =>
    _$ShippingImpl(
      isEmpty: json['isEmpty'] as bool,
      address: json['address'] as String,
      city: json['city'] as String,
    );

Map<String, dynamic> _$$ShippingImplToJson(_$ShippingImpl instance) =>
    <String, dynamic>{
      'isEmpty': instance.isEmpty,
      'address': instance.address,
      'city': instance.city,
    };
