import 'package:json_annotation/json_annotation.dart';
part 'occasions_response_model.g.dart';

@JsonSerializable()
class OccasionsResponseModel {
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'metadata')
  Metadata? metadata;
  @JsonKey(name: 'occasions')
  List<Occasions>? occasions;

  OccasionsResponseModel({this.message, this.metadata, this.occasions});

  factory OccasionsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OccasionsResponseModelFromJson(json);

  static List<OccasionsResponseModel> fromList(
      List<Map<String, dynamic>> list) {
    return list.map(OccasionsResponseModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$OccasionsResponseModelToJson(this);
}

@JsonSerializable()
class Occasions {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'slug')
  String? slug;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;

  Occasions(
      {this.id,
      this.name,
      this.slug,
      this.image,
      this.createdAt,
      this.updatedAt});

  factory Occasions.fromJson(Map<String, dynamic> json) =>
      _$OccasionsFromJson(json);

  static List<Occasions> fromList(List<Map<String, dynamic>> list) {
    return list.map(Occasions.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$OccasionsToJson(this);
}

@JsonSerializable()
class Metadata {
  @JsonKey(name: 'currentPage')
  int? currentPage;
  @JsonKey(name: 'numberOfPages')
  int? numberOfPages;
  @JsonKey(name: 'limit')
  int? limit;

  Metadata({this.currentPage, this.numberOfPages, this.limit});

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  static List<Metadata> fromList(List<Map<String, dynamic>> list) {
    return list.map(Metadata.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}
