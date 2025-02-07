import 'package:dio/dio.dart';
import 'package:flutter_one_signal_app/data/services/repo_interface/notification_repo.dart';
import 'package:flutter_one_signal_app/data/services/repository/notification_repo_impl.dart';
import 'package:flutter_one_signal_app/pages/home/bloc/notification_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../data/network/api/dio_api.dart';
import 'storage_utils.dart';

final sl = GetIt.instance;

Future<void> initDependency() async {
  //**  SERVICES
  sl.registerLazySingleton<Dio>(
    () => Dio(),
  );
  sl.registerSingleton(
    StorageUtils(),
  );
  sl.registerSingleton(
    DioApi(
      sl<Dio>(),
      sl<StorageUtils>(),
    ),
  );

  //**  REPOSITORIES
  sl.registerLazySingleton<NotificationRepo>(
    () => NotificationRepoImpl(
      sl<DioApi>(),
    ),
  );
  //**  BLOCS
  sl.registerFactory(
    () => NotificationBloc(sl<NotificationRepo>()),
  );
}
