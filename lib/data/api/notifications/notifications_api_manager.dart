import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/api/api_const.dart';
import '../../models/notifications/notifications_response_model.dart';

part 'notifications_api_manager.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class NotificationsApiManager {
  @factoryMethod
  factory NotificationsApiManager(Dio dio) = _NotificationsApiManager;

  @GET(ApiConstants.getAllNotifications)
  Future<NotificationsResponseModel> getAllNotifications(
    @Header("Authorization") String token,
    @Query("sort") String key,
  );
}
