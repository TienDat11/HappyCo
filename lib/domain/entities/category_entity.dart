/// Category Entity
///
/// Domain layer entity representing a product category
class CategoryEntity {
  final String id;
  final String name;
  final String? iconName;

  const CategoryEntity({
    required this.id,
    required this.name,
    this.iconName,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CategoryEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
