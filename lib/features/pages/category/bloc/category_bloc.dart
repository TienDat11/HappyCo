import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyco/core/bloc/bloc.dart';
import 'package:happyco/domain/entities/banner_entity.dart';
import 'package:happyco/domain/entities/category_entity.dart';
import 'package:happyco/domain/entities/product_entity.dart';
import 'package:happyco/domain/usecases/get_banners_usecase.dart';
import 'package:happyco/domain/usecases/get_categories_usecase.dart';
import 'package:happyco/domain/usecases/get_category_products_usecase.dart';
import 'package:happyco/domain/usecases/search_products_usecase.dart';

part 'category_event.dart';
part 'category_state.dart';

/// CategoryBloc
///
/// Manages category page state.
/// Loads all categories and their products, handles expand/collapse toggle,
/// category filtering, and search functionality.
class CategoryBloc extends BaseBloc<CategoryEvent, CategoryState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetCategoryProductsUseCase getCategoryProductsUseCase;
  final SearchProductsUseCase searchProductsUseCase;
  final GetBannersUseCase getBannersUseCase;

  Timer? _debounceTimer;

  CategoryBloc({
    required this.getCategoriesUseCase,
    required this.getCategoryProductsUseCase,
    required this.searchProductsUseCase,
    required this.getBannersUseCase,
  }) : super(CategoryInitial()) {
    on<OnCategoryInitialize>(_onInitialize);
    on<OnCategoryToggleExpansion>(_onToggleExpansion);
    on<OnCategoryRefresh>(_onRefresh);
    on<OnCategoryFilterSelected>(_onCategoryFilterSelected);
    on<OnCategorySearch>(_onSearch);
    on<OnCategorySearchCleared>(_onSearchCleared);
  }

  Future<void> _onInitialize(
    OnCategoryInitialize event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    await _loadAllCategoriesAndProducts(emit);
  }

  Future<void> _onToggleExpansion(
    OnCategoryToggleExpansion event,
    Emitter<CategoryState> emit,
  ) async {
    if (state is CategoryLoaded) {
      final currentState = state as CategoryLoaded;
      emit(currentState.copyWithToggle(event.categoryId));
    }
  }

  Future<void> _onRefresh(
    OnCategoryRefresh event,
    Emitter<CategoryState> emit,
  ) async {
    await _loadAllCategoriesAndProducts(emit);
  }

  Future<void> _onCategoryFilterSelected(
    OnCategoryFilterSelected event,
    Emitter<CategoryState> emit,
  ) async {
    final currentState = state;
    if (currentState is! CategoryLoaded) return;

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
      if (state is CategoryLoaded) {
        emit((state as CategoryLoaded).copyWith(
          filteredProducts: products,
        ));
      }
    } catch (e, stackTrace) {
      emitError(
        emit,
        CategoryError(error: e.toString()),
        e,
        stackTrace,
      );
    }
  }

  Future<void> _onSearch(
    OnCategorySearch event,
    Emitter<CategoryState> emit,
  ) async {
    final query = event.query.trim();
    if (query.isEmpty) {
      add(OnCategorySearchCleared());
      return;
    }

    final currentState = state;
    if (currentState is! CategoryLoaded) return;

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

    if (state is! CategoryLoaded) return;

    emit((state as CategoryLoaded).copyWith(
      searchQuery: query,
      isSearching: true,
      selectedCategoryId: () => null,
    ));

    try {
      final products = await searchProductsUseCase.exec(query);
      if (state is CategoryLoaded &&
          (state as CategoryLoaded).searchQuery == query) {
        emit((state as CategoryLoaded).copyWith(
          filteredProducts: products,
        ));
      }
    } catch (e, stackTrace) {
      emitError(
        emit,
        CategoryError(error: e.toString()),
        e,
        stackTrace,
      );
    }
  }

  Future<void> _onSearchCleared(
    OnCategorySearchCleared event,
    Emitter<CategoryState> emit,
  ) async {
    _debounceTimer?.cancel();
    final currentState = state;
    if (currentState is! CategoryLoaded) return;

    emit(currentState.copyWith(
      searchQuery: '',
      isSearching: false,
      filteredProducts: const [],
      selectedCategoryId: () => null,
    ));
  }

  Future<void> _loadAllCategoriesAndProducts(
    Emitter<CategoryState> emit,
  ) async {
    try {
      // 1. Fetch all categories and banners in parallel
      final results = await Future.wait([
        getCategoriesUseCase.exec(),
        getBannersUseCase.exec(),
      ]);
      final allCategories = results[0] as List<CategoryEntity>;
      final banners = results[1] as List<BannerEntity>;

      // 2. Filter categories with products
      final categoriesWithProducts =
          allCategories.where((c) => c.hasProducts).toList();

      if (categoriesWithProducts.isEmpty) {
        emit(CategoryLoaded(
          categories: [],
          productsByCategory: {},
          expandedCategoryIds: {},
          banners: banners,
        ));
        return;
      }

      // 3. Fetch products for all categories in parallel
      final productFutures = categoriesWithProducts.map(
        (category) => getCategoryProductsUseCase.exec(category.id),
      );
      final productResults = await Future.wait(productFutures);

      // 4. Build products map
      final Map<String, List<ProductEntity>> productsByCategory = {};
      for (var i = 0; i < categoriesWithProducts.length; i++) {
        productsByCategory[categoriesWithProducts[i].id] = productResults[i];
      }

      // 5. Auto-expand first 3 categories
      final expandedIds =
          categoriesWithProducts.take(3).map((c) => c.id).toSet();

      emit(CategoryLoaded(
        categories: categoriesWithProducts,
        productsByCategory: productsByCategory,
        expandedCategoryIds: expandedIds,
        banners: banners,
      ));
    } catch (e, stackTrace) {
      emitError(
        emit,
        CategoryError(error: e.toString()),
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
