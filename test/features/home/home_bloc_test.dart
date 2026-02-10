import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:happyco/core/services/talker_service.dart';
import 'package:happyco/domain/entities/banner_entity.dart';
import 'package:happyco/domain/entities/category_entity.dart';
import 'package:happyco/domain/entities/product_entity.dart';
import 'package:happyco/domain/usecases/get_banners_usecase.dart';
import 'package:happyco/domain/usecases/get_categories_usecase.dart';
import 'package:happyco/domain/usecases/get_category_products_usecase.dart';
import 'package:happyco/domain/usecases/get_featured_products_usecase.dart';
import 'package:happyco/domain/usecases/search_products_usecase.dart';
import 'package:happyco/domain/usecases/get_products_usecase.dart';
import 'package:happyco/features/pages/home/bloc/home_bloc.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes
class MockGetFeaturedProductsUseCase extends Mock
    implements GetFeaturedProductsUseCase {}

class MockGetCategoriesUseCase extends Mock implements GetCategoriesUseCase {}

class MockGetCategoryProductsUseCase extends Mock
    implements GetCategoryProductsUseCase {}

class MockSearchProductsUseCase extends Mock implements SearchProductsUseCase {}

class MockGetBannersUseCase extends Mock implements GetBannersUseCase {}

class MockGetProductsUseCase extends Mock implements GetProductsUseCase {}

void main() {
  setUpAll(() {
    initLogger();
  });

  late HomeBloc homeBloc;
  late MockGetFeaturedProductsUseCase mockGetFeaturedProductsUseCase;
  late MockGetCategoriesUseCase mockGetCategoriesUseCase;
  late MockGetCategoryProductsUseCase mockGetCategoryProductsUseCase;
  late MockSearchProductsUseCase mockSearchProductsUseCase;
  late MockGetBannersUseCase mockGetBannersUseCase;
  late MockGetProductsUseCase mockGetProductsUseCase;

  final tFeaturedProducts = [
    ProductEntity(
      id: '1',
      name: 'Product 1',
      priceInVnd: 100000,
      imageUrl: 'https://example.com/image1.jpg',
      isFeatured: true,
    ),
    ProductEntity(
      id: '2',
      name: 'Product 2',
      priceInVnd: 200000,
      imageUrl: 'https://example.com/image2.jpg',
      isFeatured: true,
    ),
  ];

  final tCategories = [
    CategoryEntity(
      id: 'cat1',
      name: 'Category 1',
      productCount: 10,
    ),
    CategoryEntity(
      id: 'cat2',
      name: 'Category 2',
      productCount: 20,
    ),
  ];

  final tCategoryProducts = [
    ProductEntity(
      id: '3',
      name: 'Category Product 1',
      priceInVnd: 150000,
      imageUrl: 'https://example.com/image3.jpg',
      category: 'cat1',
    ),
  ];

  final tSearchResults = [
    ProductEntity(
      id: '4',
      name: 'Search Result 1',
      priceInVnd: 120000,
      imageUrl: 'https://example.com/image4.jpg',
    ),
  ];

  final tBanners = [
    BannerEntity(
      id: '1',
      title: 'Test Banner',
      imageUrl: 'https://example.com/banner.png',
    ),
  ];

  setUp(() {
    mockGetFeaturedProductsUseCase = MockGetFeaturedProductsUseCase();
    mockGetCategoriesUseCase = MockGetCategoriesUseCase();
    mockGetCategoryProductsUseCase = MockGetCategoryProductsUseCase();
    mockSearchProductsUseCase = MockSearchProductsUseCase();
    mockGetBannersUseCase = MockGetBannersUseCase();
    mockGetProductsUseCase = MockGetProductsUseCase();

    homeBloc = HomeBloc(
      getFeaturedProductsUseCase: mockGetFeaturedProductsUseCase,
      getCategoriesUseCase: mockGetCategoriesUseCase,
      getCategoryProductsUseCase: mockGetCategoryProductsUseCase,
      searchProductsUseCase: mockSearchProductsUseCase,
      getBannersUseCase: mockGetBannersUseCase,
      getProductsUseCase: mockGetProductsUseCase,
    );
  });

  tearDown(() {
    homeBloc.close();
  });

  group('HomeBloc', () {
    group('initial state', () {
      test('should have HomeInitial as initial state', () {
        expect(homeBloc.state, isA<HomeInitial>());
      });
    });

    group('OnHomeInitialize', () {
      blocTest<HomeBloc, HomeState>(
        'emits [HomeLoading, HomeLoaded] when data loads successfully',
        build: () {
          when(() => mockGetFeaturedProductsUseCase.exec())
              .thenAnswer((_) async => tFeaturedProducts);
          when(() => mockGetCategoriesUseCase.exec())
              .thenAnswer((_) async => tCategories);
          when(() => mockGetBannersUseCase.exec())
              .thenAnswer((_) async => tBanners);
          return homeBloc;
        },
        act: (bloc) => bloc.add(OnHomeInitialize()),
        expect: () => [
          isA<HomeLoading>(),
          isA<HomeLoaded>()
              .having(
                (state) => state.featuredProducts,
                'featuredProducts',
                tFeaturedProducts,
              )
              .having(
                (state) => state.categories,
                'categories',
                tCategories,
              )
              .having(
                (state) => state.banners,
                'banners',
                tBanners,
              )
              .having(
                (state) => state.filteredProducts,
                'filteredProducts',
                isEmpty,
              )
              .having(
                (state) => state.selectedCategoryId,
                'selectedCategoryId',
                isNull,
              )
              .having(
                (state) => state.searchQuery,
                'searchQuery',
                isEmpty,
              )
              .having(
                (state) => state.isSearching,
                'isSearching',
                false,
              ),
        ],
        verify: (_) {
          verify(() => mockGetFeaturedProductsUseCase.exec()).called(1);
          verify(() => mockGetCategoriesUseCase.exec()).called(1);
          verify(() => mockGetBannersUseCase.exec()).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'emits [HomeLoading, HomeError] when featured products fetch fails',
        build: () {
          when(() => mockGetFeaturedProductsUseCase.exec())
              .thenThrow(Exception('Failed to fetch featured products'));
          when(() => mockGetCategoriesUseCase.exec())
              .thenAnswer((_) async => tCategories);
          when(() => mockGetBannersUseCase.exec())
              .thenAnswer((_) async => tBanners);
          return homeBloc;
        },
        act: (bloc) => bloc.add(OnHomeInitialize()),
        expect: () => [
          isA<HomeLoading>(),
          isA<HomeError>().having(
            (state) => state.error,
            'error',
            contains('Exception'),
          ),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'emits [HomeLoading, HomeError] when categories fetch fails',
        build: () {
          when(() => mockGetFeaturedProductsUseCase.exec())
              .thenAnswer((_) async => tFeaturedProducts);
          when(() => mockGetCategoriesUseCase.exec())
              .thenThrow(Exception('Failed to fetch categories'));
          when(() => mockGetBannersUseCase.exec())
              .thenAnswer((_) async => tBanners);
          return homeBloc;
        },
        act: (bloc) => bloc.add(OnHomeInitialize()),
        expect: () => [
          isA<HomeLoading>(),
          isA<HomeError>().having(
            (state) => state.error,
            'error',
            contains('Exception'),
          ),
        ],
      );
    });

    group('OnHomeRefresh', () {
      blocTest<HomeBloc, HomeState>(
        'emits [HomeLoaded] with updated data when refresh succeeds',
        build: () {
          when(() => mockGetFeaturedProductsUseCase.exec())
              .thenAnswer((_) async => tFeaturedProducts);
          when(() => mockGetCategoriesUseCase.exec())
              .thenAnswer((_) async => tCategories);
          when(() => mockGetBannersUseCase.exec())
              .thenAnswer((_) async => tBanners);
          return homeBloc;
        },
        seed: () => HomeLoaded(
          featuredProducts: [],
          categories: [],
        ),
        act: (bloc) => bloc.add(OnHomeRefresh()),
        expect: () => [
          isA<HomeLoaded>()
              .having(
                (state) => state.featuredProducts,
                'featuredProducts',
                tFeaturedProducts,
              )
              .having(
                (state) => state.categories,
                'categories',
                tCategories,
              )
              .having(
                (state) => state.banners,
                'banners',
                tBanners,
              ),
        ],
        verify: (_) {
          verify(() => mockGetFeaturedProductsUseCase.exec()).called(1);
          verify(() => mockGetCategoriesUseCase.exec()).called(1);
          verify(() => mockGetBannersUseCase.exec()).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'emits [HomeError] when refresh fails',
        build: () {
          when(() => mockGetFeaturedProductsUseCase.exec())
              .thenThrow(Exception('Failed to refresh'));
          when(() => mockGetCategoriesUseCase.exec())
              .thenAnswer((_) async => tCategories);
          when(() => mockGetBannersUseCase.exec())
              .thenAnswer((_) async => tBanners);
          return homeBloc;
        },
        seed: () => HomeLoaded(
          featuredProducts: tFeaturedProducts,
          categories: tCategories,
        ),
        act: (bloc) => bloc.add(OnHomeRefresh()),
        expect: () => [
          isA<HomeError>().having(
            (state) => state.error,
            'error',
            contains('Exception'),
          ),
        ],
      );
    });

    group('OnHomeCategorySelected', () {
      blocTest<HomeBloc, HomeState>(
        'emits [HomeLoaded] with selectedCategoryId=null and empty filteredProducts when categoryId is null (Tất cả)',
        build: () => homeBloc,
        seed: () => HomeLoaded(
          featuredProducts: tFeaturedProducts,
          categories: tCategories,
          filteredProducts: tCategoryProducts,
          selectedCategoryId: 'cat1',
          isSearching: true,
          searchQuery: 'test',
        ),
        act: (bloc) => bloc.add(OnHomeCategorySelected(categoryId: null)),
        expect: () => [
          isA<HomeLoaded>()
              .having(
                (state) => state.selectedCategoryId,
                'selectedCategoryId',
                isNull,
              )
              .having(
                (state) => state.filteredProducts,
                'filteredProducts',
                isEmpty,
              )
              .having(
                (state) => state.isSearching,
                'isSearching',
                false,
              )
              .having(
                (state) => state.searchQuery,
                'searchQuery',
                isEmpty,
              ),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'emits [HomeLoaded] with category products when categoryId is provided',
        build: () {
          when(() => mockGetCategoryProductsUseCase.exec(any()))
              .thenAnswer((_) async => tCategoryProducts);
          return homeBloc;
        },
        seed: () => HomeLoaded(
          featuredProducts: tFeaturedProducts,
          categories: tCategories,
        ),
        act: (bloc) => bloc.add(OnHomeCategorySelected(categoryId: 'cat1')),
        expect: () => [
          isA<HomeLoaded>()
              .having(
                (state) => state.selectedCategoryId,
                'selectedCategoryId',
                'cat1',
              )
              .having(
                (state) => state.isSearching,
                'isSearching',
                false,
              )
              .having(
                (state) => state.searchQuery,
                'searchQuery',
                isEmpty,
              ),
          isA<HomeLoaded>().having(
            (state) => state.filteredProducts,
            'filteredProducts',
            tCategoryProducts,
          ),
        ],
        verify: (_) {
          verify(() => mockGetCategoryProductsUseCase.exec('cat1')).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'emits [HomeError] when fetching category products fails',
        build: () {
          when(() => mockGetCategoryProductsUseCase.exec(any()))
              .thenThrow(Exception('Failed to fetch category products'));
          return homeBloc;
        },
        seed: () => HomeLoaded(
          featuredProducts: tFeaturedProducts,
          categories: tCategories,
        ),
        act: (bloc) => bloc.add(OnHomeCategorySelected(categoryId: 'cat1')),
        expect: () => [
          isA<HomeLoaded>().having(
            (state) => state.selectedCategoryId,
            'selectedCategoryId',
            'cat1',
          ),
          isA<HomeError>().having(
            (state) => state.error,
            'error',
            contains('Exception'),
          ),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'does nothing when state is not HomeLoaded',
        build: () => homeBloc,
        act: (bloc) => bloc.add(OnHomeCategorySelected(categoryId: 'cat1')),
        expect: () => [],
      );
    });

    group('OnHomeSearch', () {
      blocTest<HomeBloc, HomeState>(
        'emits [HomeLoaded] with search results after debounce delay',
        build: () {
          when(() => mockSearchProductsUseCase.exec(any()))
              .thenAnswer((_) async => tSearchResults);
          return homeBloc;
        },
        seed: () => HomeLoaded(
          featuredProducts: tFeaturedProducts,
          categories: tCategories,
        ),
        act: (bloc) => bloc.add(OnHomeSearch(query: 'test')),
        wait: const Duration(milliseconds: 350),
        expect: () => [
          isA<HomeLoaded>()
              .having(
                (state) => state.searchQuery,
                'searchQuery',
                'test',
              )
              .having(
                (state) => state.isSearching,
                'isSearching',
                true,
              )
              .having(
                (state) => state.selectedCategoryId,
                'selectedCategoryId',
                isNull,
              ),
          isA<HomeLoaded>().having(
            (state) => state.filteredProducts,
            'filteredProducts',
            tSearchResults,
          ),
        ],
        verify: (_) {
          verify(() => mockSearchProductsUseCase.exec('test')).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'triggers OnHomeSearchCleared when query is empty',
        build: () => homeBloc,
        seed: () => HomeLoaded(
          featuredProducts: tFeaturedProducts,
          categories: tCategories,
          filteredProducts: tSearchResults,
          searchQuery: 'test',
          isSearching: true,
        ),
        act: (bloc) => bloc.add(OnHomeSearch(query: '   ')),
        expect: () => [
          isA<HomeLoaded>()
              .having(
                (state) => state.searchQuery,
                'searchQuery',
                isEmpty,
              )
              .having(
                (state) => state.isSearching,
                'isSearching',
                false,
              )
              .having(
                (state) => state.filteredProducts,
                'filteredProducts',
                isEmpty,
              )
              .having(
                (state) => state.selectedCategoryId,
                'selectedCategoryId',
                isNull,
              ),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'emits [HomeError] when search fails',
        build: () {
          when(() => mockSearchProductsUseCase.exec(any()))
              .thenThrow(Exception('Search failed'));
          return homeBloc;
        },
        seed: () => HomeLoaded(
          featuredProducts: tFeaturedProducts,
          categories: tCategories,
        ),
        act: (bloc) => bloc.add(OnHomeSearch(query: 'test')),
        wait: const Duration(milliseconds: 350),
        expect: () => [
          isA<HomeLoaded>().having(
            (state) => state.searchQuery,
            'searchQuery',
            'test',
          ),
          isA<HomeError>().having(
            (state) => state.error,
            'error',
            contains('Exception'),
          ),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'does nothing when state is not HomeLoaded',
        build: () => homeBloc,
        act: (bloc) => bloc.add(OnHomeSearch(query: 'test')),
        expect: () => [],
      );

      blocTest<HomeBloc, HomeState>(
        'cancels previous debounce timer when new query is entered',
        build: () {
          when(() => mockSearchProductsUseCase.exec(any()))
              .thenAnswer((_) async => tSearchResults);
          return homeBloc;
        },
        seed: () => HomeLoaded(
          featuredProducts: tFeaturedProducts,
          categories: tCategories,
        ),
        act: (bloc) async {
          bloc.add(OnHomeSearch(query: 'test1'));
          await Future.delayed(const Duration(milliseconds: 100));
          bloc.add(OnHomeSearch(query: 'test2'));
        },
        wait: const Duration(milliseconds: 400),
        expect: () => [
          isA<HomeLoaded>().having(
            (state) => state.searchQuery,
            'searchQuery',
            'test2',
          ),
          isA<HomeLoaded>().having(
            (state) => state.filteredProducts,
            'filteredProducts',
            tSearchResults,
          ),
        ],
        verify: (_) {
          verifyNever(() => mockSearchProductsUseCase.exec('test1'));
          verify(() => mockSearchProductsUseCase.exec('test2')).called(1);
        },
      );
    });

    group('OnHomeSearchCleared', () {
      blocTest<HomeBloc, HomeState>(
        'resets search state and returns to featured products',
        build: () => homeBloc,
        seed: () => HomeLoaded(
          featuredProducts: tFeaturedProducts,
          categories: tCategories,
          filteredProducts: tSearchResults,
          searchQuery: 'test',
          isSearching: true,
          selectedCategoryId: 'cat1',
        ),
        act: (bloc) => bloc.add(OnHomeSearchCleared()),
        expect: () => [
          isA<HomeLoaded>()
              .having(
                (state) => state.searchQuery,
                'searchQuery',
                isEmpty,
              )
              .having(
                (state) => state.isSearching,
                'isSearching',
                false,
              )
              .having(
                (state) => state.filteredProducts,
                'filteredProducts',
                isEmpty,
              )
              .having(
                (state) => state.selectedCategoryId,
                'selectedCategoryId',
                isNull,
              ),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'does nothing when state is not HomeLoaded',
        build: () => homeBloc,
        act: (bloc) => bloc.add(OnHomeSearchCleared()),
        expect: () => [],
      );
    });

    group('HomeLoaded displayProducts', () {
      test(
          'displayProducts returns featured products when not searching and no category selected',
          () {
        final state = HomeLoaded(
          featuredProducts: tFeaturedProducts,
          categories: tCategories,
        );

        expect(state.displayProducts, tFeaturedProducts);
      });

      test('displayProducts returns filtered products when searching', () {
        final state = HomeLoaded(
          featuredProducts: tFeaturedProducts,
          categories: tCategories,
          filteredProducts: tSearchResults,
          searchQuery: 'test',
          isSearching: true,
        );

        expect(state.displayProducts, tSearchResults);
      });

      test('displayProducts returns filtered products when category selected',
          () {
        final state = HomeLoaded(
          featuredProducts: tFeaturedProducts,
          categories: tCategories,
          filteredProducts: tCategoryProducts,
          selectedCategoryId: 'cat1',
        );

        expect(state.displayProducts, tCategoryProducts);
      });

      test(
          'displayProducts returns filtered products when both searching and category selected',
          () {
        final state = HomeLoaded(
          featuredProducts: tFeaturedProducts,
          categories: tCategories,
          filteredProducts: tSearchResults,
          searchQuery: 'test',
          isSearching: true,
          selectedCategoryId: 'cat1',
        );

        expect(state.displayProducts, tSearchResults);
      });
    });
  });
}
