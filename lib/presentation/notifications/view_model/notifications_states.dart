import '../../../data/models/notifications/notifications_response_model.dart';

sealed class NotificationsState {}

final class NotificationsInitial extends NotificationsState {}

final class NotificationsLoading extends NotificationsState {}

final class NotificationsSuccess extends NotificationsState {
  final List<Notification> notifications;
  NotificationsSuccess(this.notifications);
}

final class NotificationsFailure extends NotificationsState {}

final class NotificationsEmpty extends NotificationsState {}
