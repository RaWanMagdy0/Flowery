import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../data/models/notifications/notifications_response_model.dart';
import '../../repository/notifications/notifications_repo.dart';

@injectable
class GetNotificationsUseCase {
  NotificationsRepo repository;

  GetNotificationsUseCase({required this.repository});

  Future<Result<List<Notification>?>> invoke() async {
    return await repository.getAllNotifications();
  }
}
