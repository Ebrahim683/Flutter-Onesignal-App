sealed class NotificationState {}

class NotificationInitialState extends NotificationState {}

class NotificationLoadingState extends NotificationState {}

class NotificationCreatedState extends NotificationState {}

class NotificationErrorState extends NotificationState {
  final String error;
  NotificationErrorState(this.error);
}
