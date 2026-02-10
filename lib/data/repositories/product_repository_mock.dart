import 'package:happyco/domain/entities/product_detail_entity.dart';
import 'package:happyco/domain/entities/product_entity.dart';
import 'package:happyco/domain/repositories/product_repository.dart';

/// Product Repository Mock Implementation
///
/// Provides mock data for development.
/// Replace with ProductRepositoryImpl connected to API for production.
class ProductRepositoryMock implements ProductRepository {
  /// Mock data for all 8 categories
  final Map<String, List<ProductEntity>> _mockData;

  ProductRepositoryMock()
      : _mockData = {
          'dining_set': [
            ProductEntity(
              id: 'ds_1',
              name: 'Bộ bàn ăn gỗ sồi 6 ghế',
              priceInVnd: 12500000,
              oldPriceInVnd: 15000000,
              imageUrl:
                  'https://images.unsplash.com/photo-1617806118233-18e1de247200d2?w=400',
              category: 'dining_set',
              isFeatured: true,
            ),
            ProductEntity(
              id: 'ds_2',
              name: 'Bàn ăn gỗ hương thơm 6 ghế',
              priceInVnd: 890000,
              oldPriceInVnd: 10500000,
              imageUrl:
                  'https://images.unsplash.com/photo-1617806118233-18e1de247200d2?w=400',
              category: 'dining_set',
              isFeatured: false,
            ),
          ],
          'dining_chair': [
            ProductEntity(
              id: 'dc_1',
              name: 'Ghế ăn gỗ tự nhiên',
              priceInVnd: 1200000,
              oldPriceInVnd: 15000000,
              imageUrl:
                  'https://images.unsplash.com/photo-1592078615290-033ee584e267d2?w=400',
              category: 'dining_chair',
              isFeatured: true,
            ),
          ],
          'sofa': [
            ProductEntity(
              id: 'sf_1',
              name: 'Sofa gỗ óc chó',
              priceInVnd: 12800000,
              oldPriceInVnd: 15000000,
              imageUrl:
                  'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
              category: 'sofa',
              isFeatured: true,
            ),
          ],
          'shoe_cabinet': [
            ProductEntity(
              id: 'sc_1',
              name: 'Tủ giày cao cấp',
              priceInVnd: 1620000,
              oldPriceInVnd: 17000000,
              imageUrl:
                  'https://images.unsplash.com/photo-1617806118233-18e1de247200d2?w=400',
              category: 'shoe_cabinet',
              isFeatured: true,
            ),
          ],
          'vanity_table': [
            ProductEntity(
              id: 'vt_1',
              name: 'Bàn trang điểm gỗ',
              priceInVnd: 4500000,
              oldPriceInVnd: 520000,
              imageUrl:
                  'https://images.unsplash.com/photo-15946203022009a762244a156bd?w=400',
              category: 'vanity_table',
              isFeatured: true,
            ),
          ],
          'altar': [
            ProductEntity(
              id: 'at_1',
              name: 'Tủ thờ gỗ cao cấp',
              priceInVnd: 890000,
              oldPriceInVnd: 10500000,
              imageUrl:
                  'https://images.unsplash.com/photo-1617806118233-18e1de247200d2?w=400',
              category: 'altar',
              isFeatured: true,
            ),
          ],
          'display_shelf': [
            ProductEntity(
              id: 'ds_1',
              name: 'Kệ sách gỗ pine',
              priceInVnd: 230000,
              oldPriceInVnd: 280000,
              imageUrl:
                  'https://images.unsplash.com/photo-1595428774223-ef52624120d2?w=400',
              category: 'display_shelf',
              isFeatured: true,
            ),
          ],
          'kitchen_cabinet': [
            ProductEntity(
              id: 'kc_1',
              name: 'Tủ bếp gỗ sồi',
              priceInVnd: 670000,
              oldPriceInVnd: 750000,
              imageUrl:
                  'https://images.unsplash.com/photo-1595428774223-ef52624120d2?w=400',
              category: 'kitchen_cabinet',
              isFeatured: true,
            ),
          ],
        };

  @override
  Future<List<ProductEntity>> getFeaturedProducts() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    return const [
      ProductEntity(
        id: '1',
        name: 'Bàn ăn gỗ sồi',
        priceInVnd: 550000,
        oldPriceInVnd: 650000,
        imageUrl:
            'https://images.unsplash.com/photo-1617806118233-18e1de247200d2?w=400',
        category: 'table',
        isFeatured: true,
      ),
      ProductEntity(
        id: '2',
        name: 'Ghế gỗ tự nhiên',
        priceInVnd: 120000,
        oldPriceInVnd: 150000,
        imageUrl:
            'https://images.unsplash.com/photo-1592078615290-033ee584e267d2?w=400',
        category: 'chair',
        isFeatured: true,
      ),
      ProductEntity(
        id: '3',
        name: 'Sofa gỗ óc chó',
        priceInVnd: 128000,
        oldPriceInVnd: 150000,
        imageUrl:
            'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
        category: 'sofa',
        isFeatured: true,
      ),
      ProductEntity(
        id: '4',
        name: 'Kệ sách gỗ pine',
        priceInVnd: 230000,
        oldPriceInVnd: 280000,
        imageUrl:
            'https://images.unsplash.com/photo-15946203022009a762244a156bd?w=400',
        category: 'shelf',
        isFeatured: true,
      ),
    ];
  }

  @override
  Future<List<ProductEntity>> getRecommendedProducts() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    return const [
      ProductEntity(
        id: '5',
        name: 'Tủ áo gỗ thông',
        priceInVnd: 420000,
        oldPriceInVnd: 500000,
        imageUrl:
            'https://images.unsplash.com/photo-1595428774223-ef52624120d2?w=400',
        category: 'wardrobe',
        isFeatured: false,
      ),
      ProductEntity(
        id: '6',
        name: 'Bàn làm việc hiện đại',
        priceInVnd: 350000,
        oldPriceInVnd: 420000,
        imageUrl:
            'https://images.unsplash.com/photo-1592078615290-033ee584e267d2?w=400',
        category: 'desk',
        isFeatured: false,
      ),
      ProductEntity(
        id: '7',
        name: 'Giường ngủ đôi',
        priceInVnd: 890000,
        oldPriceInVnd: 10500000,
        imageUrl:
            'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
        category: 'bed',
        isFeatured: false,
      ),
      ProductEntity(
        id: '8',
        name: 'Kệ TV gỗ tự nhiên',
        priceInVnd: 670000,
        oldPriceInVnd: 750000,
        imageUrl:
            'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
        category: 'shelf',
        isFeatured: false,
      ),
    ];
  }

  @override
  Future<List<ProductEntity>> getProductsByCategory(String categoryId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final categoryData = _mockData[categoryId];

    if (categoryData != null && categoryData.isNotEmpty) {
      return categoryData;
    }

    return [];
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
  Future<ProductDetailEntity> getProductDetail(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return ProductDetailEntity.empty();
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

  @override
  Future<List<ProductEntity>> getProducts({
    int limit = 6,
    int offset = 0,
    String? search,
    bool? hot,
    String? category,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final allProducts = [
      ...await getFeaturedProducts(),
      ...await getRecommendedProducts(),
      ..._mockData.values.expand((list) => list),
    ];

    // Filter by category
    List<ProductEntity> filtered = allProducts;
    if (category != null) {
      filtered = filtered.where((p) => p.category == category).toList();
    }

    // Filter by hot
    if (hot == true) {
      filtered = filtered.where((p) => p.isFeatured).toList();
    }

    // Filter by search
    if (search != null && search.isNotEmpty) {
      final lowerQuery = search.toLowerCase();
      filtered = filtered
          .where((p) => p.name.toLowerCase().contains(lowerQuery))
          .toList();
    }

    // Pagination
    final start = offset;
    final end = (offset + limit).clamp(0, filtered.length);
    return filtered.sublist(start, end);
  }
}
