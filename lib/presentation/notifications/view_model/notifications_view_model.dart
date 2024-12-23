import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../core/base/base_view_model.dart';
import '../../../domain/use_case/notifications/get_notifications_use_case.dart';
import 'notifications_states.dart';

@injectable
class NotificationsViewModel extends BaseViewModel<NotificationsState> {
  final GetNotificationsUseCase _getAllNotificationsUseCase;

  NotificationsViewModel(this._getAllNotificationsUseCase)
      : super(NotificationsInitial());

  void getAllNotifications() async {
    emit(NotificationsLoading());
    final result = await _getAllNotificationsUseCase.invoke();
    switch (result) {
      case Success():
        if (result.data?.isEmpty ?? true) {
          emit(NotificationsEmpty());
        } else {
          emit(NotificationsSuccess(result.data!));
        }
      case Fail():
        emit(NotificationsFailure());
    }
  }
}
