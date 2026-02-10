/// Category Entity
///
/// Domain layer entity representing a product category
class CategoryEntity {
  final String id;
  final String name;
  final String? iconName;
  final String? imageUrl;
  final int productCount;

  const CategoryEntity({
    required this.id,
    required this.name,
    this.iconName,
    this.imageUrl,
    this.productCount = 0,
  });

  factory CategoryEntity.empty() => const CategoryEntity(
        id: '',
        name: '',
        productCount: 0,
      );

  bool get hasProducts => productCount > 0;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CategoryEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
