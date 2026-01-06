import 'package:injectable/injectable.dart';
import 'package:happyco/domain/entities/product_entity.dart';
import 'package:happyco/domain/repositories/product_repository.dart';

/// Product Repository Mock Implementation
///
/// Provides mock data for development.
/// Replace with ProductRepositoryImpl connected to API for production.
@LazySingleton(as: ProductRepository)
class ProductRepositoryMock implements ProductRepository {
  @override
  Future<List<ProductEntity>> getFeaturedProducts() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return const [
      ProductEntity(
        id: '1',
        name: 'Bàn ăn gỗ sồi',
        priceInVnd: 5500000,
        oldPriceInVnd: 6500000,
        imageUrl:
            'https://images.unsplash.com/photo-1617806118233-18e1de247200?w=400',
        category: 'table',
        isFeatured: true,
      ),
      ProductEntity(
        id: '2',
        name: 'Ghế gỗ tự nhiên',
        priceInVnd: 1200000,
        oldPriceInVnd: 1500000,
        imageUrl:
            'https://images.unsplash.com/photo-1592078615290-033ee584e267?w=400',
        category: 'chair',
        isFeatured: true,
      ),
      ProductEntity(
        id: '3',
        name: 'Sofa gỗ óc chó',
        priceInVnd: 12800000,
        oldPriceInVnd: 15000000,
        imageUrl:
            'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
        category: 'sofa',
        isFeatured: true,
      ),
      ProductEntity(
        id: '4',
        name: 'Kệ sách gỗ pine',
        priceInVnd: 2300000,
        oldPriceInVnd: 2800000,
        imageUrl:
            'https://images.unsplash.com/photo-1594620302200-9a762244a156?w=400',
        category: 'shelf',
        isFeatured: true,
      ),
    ];
  }

  @override
  Future<List<ProductEntity>> getRecommendedProducts() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return const [
      ProductEntity(
        id: '5',
        name: 'Tủ áo gỗ thông',
        priceInVnd: 4200000,
        oldPriceInVnd: 5000000,
        imageUrl:
            'https://images.unsplash.com/photo-1595428774223-ef52624120d2?w=400',
        category: 'wardrobe',
      ),
      ProductEntity(
        id: '6',
        name: 'Bàn làm việc hiện đại',
        priceInVnd: 3500000,
        oldPriceInVnd: 4200000,
        imageUrl:
            'https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?w=400',
        category: 'desk',
      ),
      ProductEntity(
        id: '7',
        name: 'Giường ngủ đôi',
        priceInVnd: 8900000,
        oldPriceInVnd: 10500000,
        imageUrl:
            'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=400',
        category: 'bed',
      ),
      ProductEntity(
        id: '8',
        name: 'Kệ TV gỗ tự nhiên',
        priceInVnd: 6700000,
        oldPriceInVnd: 7500000,
        imageUrl:
            'https://images.unsplash.com/photo-1595428774223-ef52624120d2?w=400',
        category: 'shelf',
      ),
    ];
  }

  @override
  Future<List<ProductEntity>> getProductsByCategory(String categoryId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final allProducts = [
      ...await getFeaturedProducts(),
      ...await getRecommendedProducts(),
    ];

    return allProducts.where((p) => p.category == categoryId).toList();
  }

  @override
  Future<ProductEntity?> getProductById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final allProducts = [
      ...await getFeaturedProducts(),
      ...await getRecommendedProducts(),
    ];

    try {
      return allProducts.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<ProductEntity>> searchProducts(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (query.isEmpty) return [];

    final allProducts = [
      ...await getFeaturedProducts(),
      ...await getRecommendedProducts(),
    ];

    final lowerQuery = query.toLowerCase();
    return allProducts
        .where((p) => p.name.toLowerCase().contains(lowerQuery))
        .toList();
  }
}
