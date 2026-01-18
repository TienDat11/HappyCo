import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyco/core/bloc/base_bloc.dart';
import 'package:happyco/domain/usecases/get_news_by_category_usecase.dart';
import 'package:happyco/domain/usecases/get_latest_news_usecase.dart';
import 'package:happyco/domain/usecases/get_qa_usecase.dart';
import 'package:happyco/domain/usecases/get_promotions_usecase.dart';
import 'package:happyco/domain/usecases/get_featured_products_usecase.dart';
import 'package:happyco/domain/usecases/get_related_videos_usecase.dart';
import 'package:happyco/domain/entities/news_entity.dart';
import 'package:happyco/domain/entities/product_entity.dart';
import 'package:happyco/core/bloc/base_event.dart';
import 'package:happyco/core/bloc/base_state.dart';
import 'package:happyco/data/mockdata/mock_news_data.dart';

part 'news_event.dart';
part 'news_state.dart';

/// BLoC for managing news screen state and data fetching.
class NewsBloc extends BaseBloc<NewsEvent, NewsState> {
  final GetNewsByCategoryUseCase getNewsByCategoryUseCase;
  final GetLatestNewsUseCase getLatestNewsUseCase;
  final GetQAUseCase getQAUseCase;
  final GetPromotionsUseCase getPromotionsUseCase;
  final GetFeaturedProductsUseCase getFeaturedProductsUseCase;
  final GetRelatedVideosUseCase getRelatedVideosUseCase;

  NewsBloc({
    required this.getNewsByCategoryUseCase,
    required this.getLatestNewsUseCase,
    required this.getQAUseCase,
    required this.getPromotionsUseCase,
    required this.getFeaturedProductsUseCase,
    required this.getRelatedVideosUseCase,
  }) : super(NewsInitial()) {
    on<OnNewsInitialize>(_onInitialize);
    on<OnNewsFilterChange>(_onFilterChange);
    on<OnNewsRefresh>(_onRefresh);
  }

  Future<void> _onInitialize(
    OnNewsInitialize event,
    Emitter<NewsState> emit,
  ) async {
    emit(NewsLoading());

    // Use mock data for development
    try {
      await Future.delayed(const Duration(milliseconds: 800));

      emit(NewsLoaded(
        newsByCategory: MockNewsData.promotions,
        latestNews: MockNewsData.latestNews,
        qaList: MockNewsData.qaList,
        featuredProducts: MockNewsData.featuredProducts,
        relatedVideos: MockNewsData.relatedVideos,
        selectedCategory: NewsCategory.promotion,
        banner: MockNewsData.banner,
      ) as NewsState);
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

    emit(currentState.copyWith(selectedCategory: event.category));

    // Use mock data for development
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      final news = MockNewsData.newsByCategory[event.category] ?? [];
      emit(currentState.copyWith(newsByCategory: news));
    } catch (e) {
      // Keep existing data on filter error
    }
  }

  Future<void> _onRefresh(
    OnNewsRefresh event,
    Emitter<NewsState> emit,
  ) async {
    add(OnNewsInitialize());
  }
}
