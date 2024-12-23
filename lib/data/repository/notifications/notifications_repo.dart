import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../domain/repository/notifications/notifications_repo.dart';
import '../../data_sources/remote_data_source/notifications/notifications_remote_data_source.dart';
import '../../models/notifications/notifications_response_model.dart';

@Injectable(as: NotificationsRepo)
class NotificationsRepoImpl extends NotificationsRepo {
  final NotificationsRemoteDataSource notificationsRemoteDataSource;

  NotificationsRepoImpl({required this.notificationsRemoteDataSource});

  @override
  Future<Result<List<Notification>?>> getAllNotifications() async {
    return await notificationsRemoteDataSource.getAllNotifications();
  }
}
