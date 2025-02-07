import 'package:flutter_one_signal_app/core/config/utils/print_logger.dart';
import 'package:get_storage/get_storage.dart';

class StorageUtils {
  final _storage = GetStorage();

  void saveOnboarding(bool isFirst) {
    _storage.write('onboarding', isFirst);
  }

  void saveLogin(bool isLogin) {
    _storage.write('isLogin', isLogin.toString());
  }

  void saveToken(String token) {
    _storage.write('token', token);
  }

  void saveUserId(int uid) {
    _storage.write('uid', uid);
  }

  void saveRole(String role) {
    _storage.write('role', role);
  }

  void saveProfile(String profileData) {
    printLogger.message('saveProfile', profileData);
    _storage.write('profile', profileData);
  }

  bool getOnboarding() => _storage.read('onboarding') ?? true;
  String getLogin() => _storage.read('isLogin') ?? '';
  String getToken() => _storage.read('token') ?? '';
  int getUserId() => _storage.read('uid') ?? -1;
  String getRole() => _storage.read('role') ?? '';
  String getProfile() => _storage.read('profile') ?? '';

  logout() {
    _storage.remove('isLogin');
    _storage.remove('token');
    _storage.remove('role');
    _storage.remove('uid');
    _storage.remove('profile');
  }
}
