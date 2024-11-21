// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'occastions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Occastions _$OccastionsFromJson(Map<String, dynamic> json) => Occastions(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      image: json['image'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$OccastionsToJson(Occastions instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'image': instance.image,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
