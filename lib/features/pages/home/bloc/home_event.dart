part of 'home_bloc.dart';

/// Home Events
sealed class HomeEvent extends BaseEvent {}

/// Initialize home page
class OnHomeInitialize extends HomeEvent {}

/// Refresh home page data
class OnHomeRefresh extends HomeEvent {}
