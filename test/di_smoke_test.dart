import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:happyco/domain/usecases/get_banners_usecase.dart';
import 'package:happyco/domain/usecases/get_products_usecase.dart';
import 'package:happyco/domain/usecases/get_categories_usecase.dart';
import 'package:happyco/features/pages/home/bloc/home_bloc.dart';
import 'package:happyco/setup_locator.dart';

/// DI Smoke Test
///
/// Verifies all critical UseCases and BLoCs are registered
void main() async {
  print('🔍 DI Smoke Test Starting...\n');

  try {
    // Setup DI
    await setupLocator();
    print('✅ DI initialization completed\n');

    // Test GetBannersUseCase
    try {
      final bannersUseCase = GetIt.instance<GetBannersUseCase>();
      print('✅ GetBannersUseCase: REGISTERED (${bannersUseCase.runtimeType})');
    } catch (e) {
      print('❌ GetBannersUseCase: FAILED - $e');
      rethrow;
    }

    // Test GetProductsUseCase
    try {
      final productsUseCase = GetIt.instance<GetProductsUseCase>();
      print(
          '✅ GetProductsUseCase: REGISTERED (${productsUseCase.runtimeType})');
    } catch (e) {
      print('❌ GetProductsUseCase: FAILED - $e');
      rethrow;
    }

    // Test GetCategoriesUseCase
    try {
      final categoriesUseCase = GetIt.instance<GetCategoriesUseCase>();
      print(
          '✅ GetCategoriesUseCase: REGISTERED (${categoriesUseCase.runtimeType})');
    } catch (e) {
      print('❌ GetCategoriesUseCase: FAILED - $e');
      rethrow;
    }

    // Test HomeBloc (depends on all three UseCases)
    try {
      final homeBloc = GetIt.instance<HomeBloc>();
      print('✅ HomeBloc: REGISTERED (${homeBloc.runtimeType})');
    } catch (e) {
      print('❌ HomeBloc: FAILED - $e');
      rethrow;
    }

    print('\n🎉 All DI registrations verified successfully!');
    print(
        '   The "Bad state: GetIt: Object/factory not registered" error should now be fixed.');
  } catch (e, stack) {
    print('\n❌ DI Smoke Test FAILED!');
    print('   Error: $e');
    print('   Stack: $stack');
    exit(1);
  }
}
