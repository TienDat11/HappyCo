import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyco/core/bloc/base_bloc.dart';
import 'package:happyco/core/bloc/base_event.dart';
import 'package:happyco/core/bloc/base_state.dart';
import 'package:happyco/domain/entities/notification_entity.dart';
import 'package:happyco/domain/usecases/get_notification_detail_usecase.dart';

part 'notification_detail_event.dart';
part 'notification_detail_state.dart';

class NotificationDetailBloc
    extends BaseBloc<NotificationDetailEvent, NotificationDetailState> {
  final GetNotificationDetailUsecase getNotificationDetailUsecase;

  NotificationDetailBloc({
    required this.getNotificationDetailUsecase,
  }) : super(NotificationDetailInitial()) {
    on<OnNotificationDetailInitialize>(_onInitialize);
    on<OnNotificationDetailRefresh>(_onRefresh);
  }

  Future<void> _onInitialize(
    OnNotificationDetailInitialize event,
    Emitter<NotificationDetailState> emit,
  ) async {
    emit(NotificationDetailLoading());
    await _loadDetail(event.id, emit);
  }

  Future<void> _onRefresh(
    OnNotificationDetailRefresh event,
    Emitter<NotificationDetailState> emit,
  ) async {
    await _loadDetail(event.id, emit);
  }

  Future<void> _loadDetail(
    String id,
    Emitter<NotificationDetailState> emit,
  ) async {
    try {
      final notification =
          await getNotificationDetailUsecase.exec(id);

      emit(
        NotificationDetailLoaded(
          notificationDetail: notification,
        ),
      );
    } catch (e, stackTrace) {
      emitError(
        emit,
        NotificationDetailError(error: e.toString()),
        e,
        stackTrace,
      );
    }
  } 
}
