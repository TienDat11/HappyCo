import 'package:bloc/bloc.dart';
import 'package:happyco/core/bloc/base_bloc.dart';
import 'package:happyco/core/bloc/base_event.dart';
import 'package:happyco/core/bloc/base_state.dart';
import 'package:happyco/domain/entities/notification_entity.dart';
import 'package:happyco/domain/usecases/get_nottification_items_usecase.dart';

part 'notification_page_event.dart';
part 'notification_page_state.dart';

class NotificationPageBloc
    extends BaseBloc<NotificationPageEvent, NotificationPageState> {
  final GetNottificationItemsUsecase getNottificationItemsUsecase;

  NotificationPageBloc({required this.getNottificationItemsUsecase})
      : super(NotificationInitial()) {
    on<OnNotificationInitialize>(_onInitialize);
    on<OnNotificationRefresh>(_onRefresh);
  }
  Future<void> _onInitialize(
    OnNotificationInitialize event,
    Emitter<NotificationPageState> emit,
  ) async {
    emit(NotificationLoading());
    await _loadProducts(emit);
  }

  Future<void> _onRefresh(
    OnNotificationRefresh event,
    Emitter<NotificationPageState> emit,
  ) async {
    await _loadProducts(emit);
  }

  Future<void> _loadProducts(Emitter<NotificationPageState> emit) async {
    try {
      final results = await Future.wait([
        getNottificationItemsUsecase.exec(),
      ]);

      emit(NotificationLoaded(
        notifications: results[0],
      ));
    } catch (e, stackTrace) {
      emitError(
        emit,
        NotificationError(error: e.toString()),
        e,
        stackTrace,
      );
    }
  }
}
