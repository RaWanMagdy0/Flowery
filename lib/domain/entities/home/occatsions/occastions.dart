import 'package:json_annotation/json_annotation.dart';
part 'occastions.g.dart';
@JsonSerializable()
class Occastions {
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

  Occastions(
      {this.id,
      this.name,
      this.slug,
      this.image,
      this.createdAt,
      this.updatedAt});

  factory Occastions.fromJson(Map<String, dynamic> json) =>
      _$OccastionsFromJson(json);

  static List<Occastions> fromList(List<Map<String, dynamic>> list) {
    return list.map(Occastions.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$OccastionsToJson(this);
}
