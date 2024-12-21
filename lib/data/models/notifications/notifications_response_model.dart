import 'package:json_annotation/json_annotation.dart';

import '../home/occasions/occasions_response_model.dart';

part 'notifications_response_model.g.dart';

@JsonSerializable()
class NotificationsResponseModel {
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'metadata')
  Metadata? metadata;
  @JsonKey(name: 'notifications')
  List<Notification>? notifications;

  NotificationsResponseModel({this.message, this.metadata, this.notifications});

  factory NotificationsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationsResponseModelFromJson(json);

  static List<NotificationsResponseModel> fromList(
      List<Map<String, dynamic>> list) {
    return list.map(NotificationsResponseModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$NotificationsResponseModelToJson(this);
}

@JsonSerializable()
class Notification {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'body')
  String? body;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;

  Notification({
    this.id,
    this.title,
    this.body,
    this.createdAt,
    this.updatedAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  static List<Notification> fromList(List<Map<String, dynamic>> list) {
    return list.map(Notification.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}

// @JsonSerializable()
// class Metadata {
//   @JsonKey(name: 'currentPage')
//   int? currentPage;
//   @JsonKey(name: 'numberOfPages')
//   int? numberOfPages;
//   @JsonKey(name: 'limit')
//   int? limit;

//   Metadata({this.currentPage, this.numberOfPages, this.limit});

//   factory Metadata.fromJson(Map<String, dynamic> json) =>
//       _$MetadataFromJson(json);

//   static List<Metadata> fromList(List<Map<String, dynamic>> list) {
//     return list.map(Metadata.fromJson).toList();
//   }

//   Map<String, dynamic> toJson() => _$MetadataToJson(this);
// }
