import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_one_signal_app/core/constrains/enum/result_status_enum.dart';
import 'package:flutter_one_signal_app/data/services/repo_interface/notification_repo.dart';

import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepo repo;
  NotificationBloc(this.repo) : super(NotificationInitialState()) {
    on<NotificationCreateEvent>(_createNotification);
  }

  FutureOr<void> _createNotification(
    NotificationCreateEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoadingState());
    final result = await repo.createNotification();

    switch (result.status) {
      case ResultStatusEnum.success:
        emit(NotificationCreatedState());
      case ResultStatusEnum.error:
        emit(NotificationErrorState(result.error!));
    }
  }
}
