part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  final AuthorizationStatus status;
  final List<PushMessage> notifications;
  final String path;

  const NotificationsState({
    this.status = AuthorizationStatus.authorized,
    this.notifications = const [],
    this.path = '/'
  });

  NotificationsState copyWith({
    AuthorizationStatus? status,
    List<PushMessage>? notifications,
    String? path
  }) =>
      NotificationsState(
        status: status ?? this.status,
        notifications: notifications ?? this.notifications,
        path: path ?? this.path,
      );

  @override
  List<Object> get props => [status, notifications, path];
}