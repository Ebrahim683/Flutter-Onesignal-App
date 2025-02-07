import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_one_signal_app/core/config/utils/print_logger.dart';
import 'package:flutter_one_signal_app/pages/home/bloc/notification_bloc.dart';
import 'package:flutter_one_signal_app/pages/home/bloc/notification_event.dart';
import 'package:flutter_one_signal_app/pages/home/bloc/notification_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Webhook Notifier'),
        centerTitle: true,
      ),
      body: BlocConsumer<NotificationBloc, NotificationState>(
        listener: (context, state) {
          _notificationListener(state);
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                    onTap: () {
                      context
                          .read<NotificationBloc>()
                          .add(NotificationCreateEvent());
                    },
                    child: Image.asset('assets/icon.png')),
              ],
            ),
          );
        },
      ),
    );
  }

  void _notificationListener(NotificationState state) {
    if (state is NotificationCreatedState) {
      printLogger.message('notification_event', 'Created');
    } else if (state is NotificationErrorState) {
      printLogger.error('notification_event', state.error);
    }
  }
}
