import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  static final PermissionManager _instance = PermissionManager._();

  PermissionManager._();
  factory PermissionManager() => _instance;

  Future<bool> requestPermission(Permission permission) async {
    final status = await permission.status;

    if (status.isGranted) {
      return true;
    } else if (status.isDenied || status.isRestricted) {
      final result = await permission.request();
      return result.isGranted;
    }
    return false;
  }
}

final PermissionManager permissionManager = PermissionManager();
