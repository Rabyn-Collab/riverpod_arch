// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewImpl _$$ReviewImplFromJson(Map<String, dynamic> json) => _$ReviewImpl(
      username: json['username'] as String,
      comment: json['comment'] as String,
      rating: json['rating'] as num,
      user: json['user'] as String,
    );

Map<String, dynamic> _$$ReviewImplToJson(_$ReviewImpl instance) =>
    <String, dynamic>{
      'username': instance.username,
      'comment': instance.comment,
      'rating': instance.rating,
      'user': instance.user,
    };
