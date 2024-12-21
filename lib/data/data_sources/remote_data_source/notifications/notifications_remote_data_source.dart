import '../../../../core/api/api_result.dart';
import '../../../models/notifications/notifications_response_model.dart';

abstract class NotificationsRemoteDataSource {
  Future<Result<List<Notification>>> getAllNotifications();
}
