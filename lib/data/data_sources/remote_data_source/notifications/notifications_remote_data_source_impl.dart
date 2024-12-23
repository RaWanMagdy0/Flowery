import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../../core/api/execute_api_call.dart';
import '../../../../core/local/token_manger.dart';
import '../../../api/notifications/notifications_api_manager.dart';
import '../../../models/notifications/notifications_response_model.dart';
import 'notifications_remote_data_source.dart';

@Injectable(as: NotificationsRemoteDataSource)
class NotificationsRemoteDataSourceImpl extends NotificationsRemoteDataSource {
  final NotificationsApiManager apiManger;

  NotificationsRemoteDataSourceImpl(this.apiManger);

  Future<String> _getToken() async {
    var token = await TokenManager.getToken();
    if (token == null || token.isEmpty) {
      throw Exception("Token is missing. Please login again.");
    }
    return 'Bearer $token';
  }

  @override
  Future<Result<List<Notification>>> getAllNotifications() async {
    return await executeApiCall<List<Notification>>(() async {
      var token = await _getToken();
      final response = await apiManger.getAllNotifications(
        token,
        '-createdAt',
      );
      return response.notifications ?? [];
    });
  }
}
