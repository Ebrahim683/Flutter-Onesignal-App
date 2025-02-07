import 'package:flutter_one_signal_app/data/resource/result.dart';
import 'package:flutter_one_signal_app/data/services/repo_interface/notification_repo.dart';

import '../../network/api/api_service.dart';

class NotificationRepoImpl implements NotificationRepo {
  final ApiService apiService;

  NotificationRepoImpl(this.apiService);

  @override
  Future<Result> createNotification() async {
    try {
      await apiService
          .postApi(path: '/bce35091-2238-4f04-91dc-fbf35cc8e268', data: {});
      return Result.success('Notification created');
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
