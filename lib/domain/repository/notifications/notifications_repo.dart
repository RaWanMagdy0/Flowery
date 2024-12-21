import '../../../../../core/api/api_result.dart';
import '../../../data/models/notifications/notifications_response_model.dart';

abstract class NotificationsRepo {
  Future<Result<List<Notification>?>> getAllNotifications();
}
