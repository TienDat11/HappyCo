import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyco/core/bloc/base_bloc.dart';
import 'package:happyco/domain/usecases/get_news_by_category_usecase.dart';
import 'package:happyco/domain/usecases/get_news_categories_usecase.dart';
import 'package:happyco/domain/usecases/get_news_videos_usecase.dart';
import 'package:happyco/domain/entities/news_entity.dart';
import 'package:happyco/domain/entities/news_category_entity.dart';
import 'package:happyco/core/bloc/base_event.dart';
import 'package:happyco/core/bloc/base_state.dart';

part 'news_event.dart';
part 'news_state.dart';

/// BLoC for managing news screen state and data fetching.
class NewsBloc extends BaseBloc<NewsEvent, NewsState> {
  final GetNewsCategoriesUseCase getNewsCategoriesUseCase;
  final GetNewsUseCase getNewsUseCase;
  final GetNewsVideosUseCase getNewsVideosUseCase;

  NewsBloc({
    required this.getNewsCategoriesUseCase,
    required this.getNewsUseCase,
    required this.getNewsVideosUseCase,
  }) : super(NewsInitial()) {
    on<OnNewsInitialize>(_onInitialize);
    on<OnNewsFilterChange>(_onFilterChange);
    on<OnNewsSearch>(_onSearch);
    on<OnNewsRefresh>(_onRefresh);
    on<OnNewsToggleAllVideos>(_onToggleAllVideos);
  }

  Future<void> _onInitialize(
    OnNewsInitialize event,
    Emitter<NewsState> emit,
  ) async {
    emit(NewsLoading());

    try {
      final categories = await getNewsCategoriesUseCase.exec();

      if (categories.isEmpty) {
        emit(NewsError('Không có danh mục tin tức.'));
        return;
      }

      final defaultCategory = categories.first;

      final results = await Future.wait([
        getNewsUseCase.exec(GetNewsParams(categoryId: defaultCategory.id)),
        getNewsVideosUseCase.exec(),
      ]);

      final news = results[0];
      final videos = results[1];

      emit(NewsLoaded(
        categories: categories,
        selectedCategory: defaultCategory,
        newsByCategory: news,
        videos: videos,
      ));
    } catch (e, stackTrace) {
      emitError(emit, NewsError(e.toString()), e, stackTrace);
    }
  }

  Future<void> _onFilterChange(
    OnNewsFilterChange event,
    Emitter<NewsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! NewsLoaded) return;

    emit(currentState.copyWith(
      selectedCategory: event.category,
    ));

    try {
      final news = await getNewsUseCase.exec(
        GetNewsParams(
          categoryId: event.category.id,
          search: currentState.searchQuery,
        ),
      );
      final updatedState = state;
      if (updatedState is! NewsLoaded) return;
      emit(updatedState.copyWith(newsByCategory: news));
    } catch (e) {
      // Keep existing data on filter error
    }
  }

  Future<void> _onSearch(
    OnNewsSearch event,
    Emitter<NewsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! NewsLoaded) return;

    emit(currentState.copyWith(searchQuery: event.query));

    try {
      final news = await getNewsUseCase.exec(
        GetNewsParams(
          categoryId: currentState.selectedCategory.id,
          search: event.query.isEmpty ? null : event.query,
        ),
      );
      final updatedState = state;
      if (updatedState is! NewsLoaded) return;
      emit(updatedState.copyWith(newsByCategory: news));
    } catch (e) {
      // Keep existing data on search error
    }
  }

  Future<void> _onRefresh(
    OnNewsRefresh event,
    Emitter<NewsState> emit,
  ) async {
    add(OnNewsInitialize());
  }

  void _onToggleAllVideos(
    OnNewsToggleAllVideos event,
    Emitter<NewsState> emit,
  ) {
    final currentState = state;
    if (currentState is! NewsLoaded) return;
    emit(currentState.copyWith(showAllVideos: !currentState.showAllVideos));
  }
}
