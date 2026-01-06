import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyco/core/bloc/bloc.dart';
import 'package:happyco/domain/entities/product_entity.dart';
import 'package:happyco/domain/usecases/get_featured_products_usecase.dart';
import 'package:happyco/domain/usecases/get_recommended_products_usecase.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';

/// HomeBloc
///
/// Manages the state for the Home page.
/// Fetches featured and recommended products using use cases.
@injectable
class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  final GetFeaturedProductsUseCase getFeaturedProductsUseCase;
  final GetRecommendedProductsUseCase getRecommendedProductsUseCase;

  HomeBloc({
    required this.getFeaturedProductsUseCase,
    required this.getRecommendedProductsUseCase,
  }) : super(HomeInitial()) {
    on<OnHomeInitialize>(_onInitialize);
    on<OnHomeRefresh>(_onRefresh);
  }

  Future<void> _onInitialize(
    OnHomeInitialize event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    await _loadProducts(emit);
  }

  Future<void> _onRefresh(
    OnHomeRefresh event,
    Emitter<HomeState> emit,
  ) async {
    await _loadProducts(emit);
  }

  Future<void> _loadProducts(Emitter<HomeState> emit) async {
    try {
      final results = await Future.wait([
        getFeaturedProductsUseCase.exec(),
        getRecommendedProductsUseCase.exec(),
      ]);

      emit(HomeLoaded(
        featuredProducts: results[0],
        recommendedProducts: results[1],
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
}
