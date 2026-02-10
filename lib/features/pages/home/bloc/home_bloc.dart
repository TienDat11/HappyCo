import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyco/core/bloc/bloc.dart';
import 'package:happyco/domain/entities/banner_entity.dart';
import 'package:happyco/domain/entities/category_entity.dart';
import 'package:happyco/domain/entities/product_entity.dart';
import 'package:happyco/domain/usecases/get_banners_usecase.dart';
import 'package:happyco/domain/usecases/get_categories_usecase.dart';
import 'package:happyco/domain/usecases/get_category_products_usecase.dart';
import 'package:happyco/domain/usecases/get_featured_products_usecase.dart';
import 'package:happyco/domain/usecases/get_products_usecase.dart';
import 'package:happyco/domain/usecases/search_products_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

/// HomeBloc
///
/// Manages state for Home page.
/// Fetches featured products, categories, handles search and category filtering.
class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  final GetFeaturedProductsUseCase getFeaturedProductsUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetCategoryProductsUseCase getCategoryProductsUseCase;
  final SearchProductsUseCase searchProductsUseCase;
  final GetBannersUseCase getBannersUseCase;
  final GetProductsUseCase getProductsUseCase;

  Timer? _debounceTimer;

  HomeBloc({
    required this.getFeaturedProductsUseCase,
    required this.getCategoriesUseCase,
    required this.getCategoryProductsUseCase,
    required this.searchProductsUseCase,
    required this.getBannersUseCase,
    required this.getProductsUseCase,
  }) : super(HomeInitial()) {
    on<OnHomeInitialize>(_onInitialize);
    on<OnHomeRefresh>(_onRefresh);
    on<OnHomeCategorySelected>(_onCategorySelected);
    on<OnHomeSearch>(_onSearch);
    on<OnHomeSearchCleared>(_onSearchCleared);
    on<OnHomeToggleShowAll>(_onToggleShowAll);
  }

  Future<void> _onInitialize(
    OnHomeInitialize event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    await _loadInitialData(emit);
  }

  Future<void> _onRefresh(
    OnHomeRefresh event,
    Emitter<HomeState> emit,
  ) async {
    await _loadInitialData(emit);
  }

  Future<void> _onCategorySelected(
    OnHomeCategorySelected event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;
    if (currentState is! HomeLoaded) return;

    if (event.categoryId == null) {
      emit(currentState.copyWith(
        selectedCategoryId: () => null,
        filteredProducts: const [],
        isSearching: false,
        searchQuery: '',
      ));
      return;
    }

    emit(currentState.copyWith(
      selectedCategoryId: () => event.categoryId,
      isSearching: false,
      searchQuery: '',
    ));

    try {
      final products = await getCategoryProductsUseCase.exec(event.categoryId!);
      if (state is HomeLoaded) {
        emit((state as HomeLoaded).copyWith(
          filteredProducts: products,
        ));
      }
    } catch (e, stackTrace) {
      emitError(
        emit,
        HomeError(error: e.toString()),
        e,
        stackTrace,
      );
    }
  }

  Future<void> _onSearch(
    OnHomeSearch event,
    Emitter<HomeState> emit,
  ) async {
    final query = event.query.trim();
    if (query.isEmpty) {
      add(OnHomeSearchCleared());
      return;
    }

    final currentState = state;
    if (currentState is! HomeLoaded) return;

    _debounceTimer?.cancel();

    final completer = Completer<void>();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      completer.complete();
    });

    try {
      await completer.future;
    } catch (_) {
      return;
    }

    if (state is! HomeLoaded) return;

    emit((state as HomeLoaded).copyWith(
      searchQuery: query,
      isSearching: true,
      selectedCategoryId: () => null,
    ));

    try {
      final products = await searchProductsUseCase.exec(query);
      if (state is HomeLoaded && (state as HomeLoaded).searchQuery == query) {
        emit((state as HomeLoaded).copyWith(
          filteredProducts: products,
        ));
      }
    } catch (e, stackTrace) {
      emitError(
        emit,
        HomeError(error: e.toString()),
        e,
        stackTrace,
      );
    }
  }

  Future<void> _onSearchCleared(
    OnHomeSearchCleared event,
    Emitter<HomeState> emit,
  ) async {
    _debounceTimer?.cancel();
    final currentState = state;
    if (currentState is! HomeLoaded) return;

    emit(currentState.copyWith(
      searchQuery: '',
      isSearching: false,
      filteredProducts: const [],
      selectedCategoryId: () => null,
    ));
  }

  Future<void> _onToggleShowAll(
    OnHomeToggleShowAll event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;
    if (currentState is! HomeLoaded) return;

    if (currentState.isShowingAll) {
      emit(currentState.copyWith(isShowingAll: false, allProducts: const []));
      return;
    }

    try {
      final allProducts = await getProductsUseCase.exec(
        const GetProductsParams(limit: 100, offset: 0),
      );
      if (state is HomeLoaded) {
        emit((state as HomeLoaded).copyWith(
          allProducts: allProducts,
          isShowingAll: true,
        ));
      }
    } catch (e, stackTrace) {
      emitError(emit, HomeError(error: e.toString()), e, stackTrace);
    }
  }

  Future<void> _loadInitialData(Emitter<HomeState> emit) async {
    try {
      final results = await Future.wait([
        getFeaturedProductsUseCase.exec(),
        getCategoriesUseCase.exec(),
        getBannersUseCase.exec(),
      ]);

      emit(HomeLoaded(
        featuredProducts: results[0] as List<ProductEntity>,
        categories: results[1] as List<CategoryEntity>,
        banners: results[2] as List<BannerEntity>,
      ));
    } catch (e, stackTrace) {
      emitError(
        emit,
        HomeError(error: e.toString()),
        e,
        stackTrace,
      );
    }
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
