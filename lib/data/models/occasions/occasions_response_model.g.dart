// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'occasions_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OccasionsResponseModel _$OccasionsResponseModelFromJson(
        Map<String, dynamic> json) =>
    OccasionsResponseModel(
      message: json['message'] as String?,
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      occasions: (json['occasions'] as List<dynamic>?)
          ?.map((e) => Occasions.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OccasionsResponseModelToJson(
        OccasionsResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'metadata': instance.metadata,
      'occasions': instance.occasions,
    };

Occasions _$OccasionsFromJson(Map<String, dynamic> json) => Occasions(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      image: json['image'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$OccasionsToJson(Occasions instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'image': instance.image,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
      currentPage: (json['currentPage'] as num?)?.toInt(),
      numberOfPages: (json['numberOfPages'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
      'currentPage': instance.currentPage,
      'numberOfPages': instance.numberOfPages,
      'limit': instance.limit,
    };
