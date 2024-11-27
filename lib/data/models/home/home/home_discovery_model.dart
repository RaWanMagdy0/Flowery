import '../../../../domain/entities/home/home_discovery_entity.dart';

class HomeDiscoveryModel {
  final String? id;
  final String? title;
  final String? subtitle;
  final String? imageUrl;

  HomeDiscoveryModel({
    this.id,
    this.title,
    this.subtitle,
    this.imageUrl,
  });

  HomeDiscovery toEntity() => HomeDiscovery(
        id: id,
        title: title,
        subtitle: subtitle,
        imageUrl: imageUrl,
      );

  factory HomeDiscoveryModel.fromJson(Map<String, dynamic> json) {
    return HomeDiscoveryModel(
      id: json['_id'],
      title: json['title'],
      subtitle: json['subtitle'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
