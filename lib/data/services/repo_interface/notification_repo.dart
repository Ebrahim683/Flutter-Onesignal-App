import '../../resource/result.dart';

abstract interface class NotificationRepo {
  Future<Result> createNotification();
}
