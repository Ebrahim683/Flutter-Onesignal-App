import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_one_signal_app/pages/home/bloc/notification_bloc.dart';
import 'package:flutter_one_signal_app/pages/home/ui/home_page.dart';
import 'package:flutter_one_signal_app/router/router_path.dart';
import 'package:go_router/go_router.dart';

import '../core/config/services/service_locator.dart';

class AppRouter {
  static AppRouter appRouter = AppRouter._();

  AppRouter._();

  factory AppRouter() => appRouter;
  GoRouter router = GoRouter(initialLocation: routerPath.homePage, routes: [
    GoRoute(
      name: routerPath.homePage,
      path: routerPath.homePage,
      builder: (context, state) {
        return BlocProvider(
          create: (context) => NotificationBloc(sl()),
          child: const HomePage(),
        );
      },
    ),
  ]);
}

final AppRouter appRouter = AppRouter();
